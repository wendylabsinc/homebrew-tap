class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.06.11-073704"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "751b193af9a0a5326d824160e7c5158fe8976f2463b99f5051911135a3f63ef2"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.11-073704/wendy-cli-darwin-arm64-2026.06.11-073704.tar.gz"
    sha256 "8d44b1d4e6750849d39394c420a69f5b2b88ade7b3dcd1cc1ed99aecd7d314ab"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.11-073704/wendy-cli-linux-arm64-2026.06.11-073704.tar.gz"
      sha256 "746ac780801435f03939173dd79f442f01b5c279528f1cee18122d6a96a27dfc"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.11-073704/wendy-cli-linux-amd64-2026.06.11-073704.tar.gz"
      sha256 "bf7c317367106e411cb6088fa7310fdd4296b6c0f5bd101ea053b4e71be30775"
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
