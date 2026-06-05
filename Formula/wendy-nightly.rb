class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.06.05-160853"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "047948e6c7b966f49507545620ffac41b77b141b43d50b896e5fea97c09ce611"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.05-160853/wendy-cli-darwin-arm64-2026.06.05-160853.tar.gz"
    sha256 "9735ea6da06081e37f52c8376e64487bab3f2c00f774ff153feb967ba64f31b1"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.05-160853/wendy-cli-linux-arm64-2026.06.05-160853.tar.gz"
      sha256 "4b1ad69409c12a2a52d98169fb8a2155fa1f82d132782781e6a21f768507debc"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.05-160853/wendy-cli-linux-amd64-2026.06.05-160853.tar.gz"
      sha256 "eebfe6931c100f0c5a544e2fa8cb4f68c4e5639f1ae6f4f7765dfeedd8faea03"
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
