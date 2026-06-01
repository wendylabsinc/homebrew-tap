class Wendy < Formula
  desc "CLI for building and running WendyOS applications"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-2026.06.01-033236"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "78124d85cbbf6894d933b255bf9931a814a2d7f580b2d48dc5ba249d373ffec4"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.01-033236/wendy-cli-darwin-arm64-2026.06.01-033236.tar.gz"
    sha256 "7380934cc882cc177c45956fffdf3a5d7a27105ece8729ef8a1d290dc8271ad1"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.01-033236/wendy-cli-linux-arm64-2026.06.01-033236.tar.gz"
      sha256 "d0d050711f72525893a766124f7b1682bcd05fec758e4ebb40ab00baccd6e1d9"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.01-033236/wendy-cli-linux-amd64-2026.06.01-033236.tar.gz"
      sha256 "943429ca02c4b139ab1fc26d92a90fb82d0c22052cd4f87b4625d657a3391c8e"
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
