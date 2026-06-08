class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.06.08-192719"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "1d7dbb69c41e1ebf488325db32f7950a01b80197ac9bc8277e7b8eb2592b0981"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.08-192719/wendy-cli-darwin-arm64-2026.06.08-192719.tar.gz"
    sha256 "8ce4bc271e3d3cca0640594a3e7e33130569bf12f89d52b989572b989b92dfc1"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.08-192719/wendy-cli-linux-arm64-2026.06.08-192719.tar.gz"
      sha256 "456ee027565ce016a39194d23f5bcd16e73c7a66b6dc87b4a18fcadfaf4f21fb"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.08-192719/wendy-cli-linux-amd64-2026.06.08-192719.tar.gz"
      sha256 "96b57e7c441b874f1d04c89719128302bbddafaaf988429a7a7f8ebb0dd93ff2"
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
