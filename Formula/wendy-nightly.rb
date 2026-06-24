class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.06.24-153556"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "22a37a8ebccf61eda17b15e0fd36adf6626ebfa9d55938fd32f5d03c7c404341"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.24-153556/wendy-cli-darwin-arm64-2026.06.24-153556.tar.gz"
    sha256 "afa24c760d4227a7f25dcaa19daafa5b683aefddde6cd1c21738d4d4febf9c17"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.24-153556/wendy-cli-linux-arm64-2026.06.24-153556.tar.gz"
      sha256 "054f96692136089920041ece42b89f97c605dc59cbbf8800d6e4b609057452ed"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.24-153556/wendy-cli-linux-amd64-2026.06.24-153556.tar.gz"
      sha256 "64efa5301fc5794b9bd962d62c277a3f7e06a59d6ce24a7dcbfa43be6ddbea91"
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
