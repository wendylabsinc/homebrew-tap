class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.06.17-145209"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "ad4c1c295140af4e045f59eeed50059532339a226da9510977058d7251763402"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.17-145209/wendy-cli-darwin-arm64-2026.06.17-145209.tar.gz"
    sha256 "71d63337396194a969dcb08f2a5a2aa49d0a026024dd911a54c3a58aeb3500fe"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.17-145209/wendy-cli-linux-arm64-2026.06.17-145209.tar.gz"
      sha256 "c7b6ddfa0d557c169b0e2076eecc33c5eb730078f89c974976af99e214fb9f9d"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.17-145209/wendy-cli-linux-amd64-2026.06.17-145209.tar.gz"
      sha256 "4f376a613a13fdc40e1b1c22a9b0cd037b062c7e5a16d9b242f55a0e189849f0"
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
