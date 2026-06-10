class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.06.10-074902"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "0942beb1aef02ce7199f2725d1ae00c3a7115fc12ef528c94df9ea546086e93f"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.10-074902/wendy-cli-darwin-arm64-2026.06.10-074902.tar.gz"
    sha256 "db40dedd2dbe48cbe87ef4cc73669c2458b9ed2f4f0641a82b7ee13801cf7a71"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.10-074902/wendy-cli-linux-arm64-2026.06.10-074902.tar.gz"
      sha256 "2908f73bebd602935bbaa96973eb710863e3b23c366e29dd4d28f2fcb844aaed"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.10-074902/wendy-cli-linux-amd64-2026.06.10-074902.tar.gz"
      sha256 "3c83aef1a5066d17a6769c522232041e0587a680f96f171644202c57098140e1"
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
