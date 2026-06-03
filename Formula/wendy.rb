class Wendy < Formula
  desc "CLI for building and running WendyOS applications"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-2026.06.03-065502"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "b139d9a7e028b304644c4705a18d5d8167c6c2841e964e5bdb7f86f6f10b7f8f"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.03-065502/wendy-cli-darwin-arm64-2026.06.03-065502.tar.gz"
    sha256 "5a0d9bd396e9b000b813147244d84a76d26f93c5ece7811dfcc22e3edcb7bf84"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.03-065502/wendy-cli-linux-arm64-2026.06.03-065502.tar.gz"
      sha256 "fe9c51b3934ba25a72c72de234b1abddfc596ec0d8cea7c3f502b3cc4c31d54e"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.03-065502/wendy-cli-linux-amd64-2026.06.03-065502.tar.gz"
      sha256 "f76e468d95ab5fec8dbc5ff99162081ab9e9df699d7b19bb439564dc86e691d0"
    end
  end

  conflicts_with "wendy-nightly", because: "both install a `wendy` binary"

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
    # TODO: It would be better to actually build something, instead of just checking the help text.
    system bin/"wendy", "--help"
    assert_match "wendy [command]", shell_output("#{bin}/wendy --help")
  end
end
