class Wendy < Formula
  desc "CLI for building and running WendyOS applications"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-2026.06.01-021827"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "78124d85cbbf6894d933b255bf9931a814a2d7f580b2d48dc5ba249d373ffec4"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.01-021827/wendy-cli-darwin-arm64-2026.06.01-021827.tar.gz"
    sha256 "8f68c52614e9952b587087dd27039b39a6fd7f715514131425f2e6cd798322c7"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.01-021827/wendy-cli-linux-arm64-2026.06.01-021827.tar.gz"
      sha256 "62658989a1669628d8c4119f254c10d334bedc608d088d469fa639fb4b4dd469"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.01-021827/wendy-cli-linux-amd64-2026.06.01-021827.tar.gz"
      sha256 "2cc92db5cc37cec1a3b923675293fcdac9e087828d53233a33ff7b51d42a3971"
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
