class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.06.05-172449"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "ec517140dcb9c3a4607be4e979bdd6f7c8cb8be06de405792858fbf2738e61bc"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.05-172449/wendy-cli-darwin-arm64-2026.06.05-172449.tar.gz"
    sha256 "88e5b08be6057b3fa2c8910acdd239f94906ee57dd85ca01d5f60648645650a4"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.05-172449/wendy-cli-linux-arm64-2026.06.05-172449.tar.gz"
      sha256 "3ff782dbc9650564843ef246ea3480fcd5dea38de42226088b03c0017a634af3"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.05-172449/wendy-cli-linux-amd64-2026.06.05-172449.tar.gz"
      sha256 "4edce0d877c908f092dd54ea7e0c2188e3c8aed266b320b609544e5959e3bcf4"
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
