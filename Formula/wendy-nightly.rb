class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.06.04-120100"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "01518813b7fcae36ee3400ee37d8637dc3ded6818e1651afdbcc232c46bcc51f"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.04-120100/wendy-cli-darwin-arm64-2026.06.04-120100.tar.gz"
    sha256 "ff71d21dd2b39bc70ad61e2b0c02bd455bb4ed80e72b8eb2e598f0de57ac183e"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.04-120100/wendy-cli-linux-arm64-2026.06.04-120100.tar.gz"
      sha256 "eadc56700923a826f0e4a07daa4141aecf4f8b98a2ebf3850ac50e24d2043a93"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.04-120100/wendy-cli-linux-amd64-2026.06.04-120100.tar.gz"
      sha256 "8a52fbcc82dcddbc619b5224f66b141f1e05b64779b73c80523f73cbd94a14d0"
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
