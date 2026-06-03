class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.06.03-172303"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "df721c1dcaf367a9ca8ff399e7fee01d75ff28af5854de8360f2bb346959a46b"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.03-172303/wendy-cli-darwin-arm64-2026.06.03-172303.tar.gz"
    sha256 "ceca850734b2758953fd80bb93548d532a19cfbf1f1763a47fd543c478c654bc"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.03-172303/wendy-cli-linux-arm64-2026.06.03-172303.tar.gz"
      sha256 "9af4b47a627d6360ad636286c1ecbb244590fdb6c80339dbd1568c83a0082c98"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.03-172303/wendy-cli-linux-amd64-2026.06.03-172303.tar.gz"
      sha256 "4e6e2cb1983f6af12a866327da2ee504344ac7849dc1b56f1a0cc59aa540f46a"
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
