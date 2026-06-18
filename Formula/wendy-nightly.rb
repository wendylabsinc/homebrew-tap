class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.06.18-101840"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "996a780abd83b69644873ba0349d6a78f1002214a0ae914cf01cf7649bfb2d4f"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.18-101840/wendy-cli-darwin-arm64-2026.06.18-101840.tar.gz"
    sha256 "5aa6ee8cd1c83ec4dee1bdfb99455bb78b4e946a10512b0520c67ea4663284b9"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.18-101840/wendy-cli-linux-arm64-2026.06.18-101840.tar.gz"
      sha256 "49e1f365c75293a2115f36b84f95d9f0b9e017166dbccda75c1b8d7328398bef"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.18-101840/wendy-cli-linux-amd64-2026.06.18-101840.tar.gz"
      sha256 "c5fcede45482022b267b75c8db43cc050117233579b22e0d1a689a4ecd8de90b"
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
