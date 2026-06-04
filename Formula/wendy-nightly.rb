class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.06.04-073747"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "29aa2c3d6e4341468955df674f45761b378a8f6d16a9e6123ea576e778532b8b"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.04-073747/wendy-cli-darwin-arm64-2026.06.04-073747.tar.gz"
    sha256 "35efe2a02406c630d8fd1137b364bc3539c9cd23af2f857ad81ff815c13231a9"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.04-073747/wendy-cli-linux-arm64-2026.06.04-073747.tar.gz"
      sha256 "e5cdfe60559b63bd49ed2d4e83f73e8464109f66c28806c59f551646ccb4e568"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.04-073747/wendy-cli-linux-amd64-2026.06.04-073747.tar.gz"
      sha256 "6592bccc3c802238a88581baead5b41ad26b80c1c33f2093f1396dd29b5c9d5d"
    end
  end

  conflicts_with "wendy", because: "both install a `wendy` binary"

  def install
    # Install pre-built binaries (all platforms)
    bin.install "wendy"
    bin.install "wendy-helper" if File.exist?("wendy-helper")
    bin.install "wendy-network-daemon" if File.exist?("wendy-network-daemon")

    # Install macOS-specific bundle with resources (plist files, etc) if present
    bundle_path = "wendy-agent_wendy.bundle"
    (lib/"wendy").install bundle_path if File.directory?(bundle_path)

    # Generate and install shell completions
    generate_completions_from_executable(bin/"wendy", "completion")
  end

  def post_install
    quiet_system bin/"wendy", "completion", "install"
  end

  def caveats
    <<~EOS
      Attention: The Wendy CLI collects anonymous analytics.
      They help us understand which commands are used most, identify common errors, and prioritize improvements.
      Analytics are enabled by default. If you'd like to opt-out, use the following command:
        wendy analytics disable
      Or, set the following environment variable:
        WENDY_ANALYTICS=false

      To set up MCP integration with your AI tools:
        wendy mcp setup
    EOS
  end

  test do
    system bin/"wendy", "--help"
    assert_match "wendy [command]", shell_output("#{bin}/wendy --help")
  end
end
