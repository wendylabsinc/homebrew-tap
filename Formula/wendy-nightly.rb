class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.06.03-075005"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "a3416ca9b9863f8128d1952be6240b594609089184d54d6f97bd04cc88b28a7c"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.03-075005/wendy-cli-darwin-arm64-2026.06.03-075005.tar.gz"
    sha256 "4a1c2a642c0af0af5755e8aab7b9ec607a3992afafa02cea2241f34d622df936"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.03-075005/wendy-cli-linux-arm64-2026.06.03-075005.tar.gz"
      sha256 "e6b91cb70b586556d568ee2128e7133dfdd5b07397b9022a59e742a3ca66ee4c"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.03-075005/wendy-cli-linux-amd64-2026.06.03-075005.tar.gz"
      sha256 "70d7b42712edbe603e00b0cae132f04989aa1f7cac321f1573a54c452f45c3f9"
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
