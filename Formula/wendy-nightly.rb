class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.06.04-124517"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "7b89862358c098fbb3a8df6ed7efb3117d85d4ef969063b537838b905b44c22e"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.04-124517/wendy-cli-darwin-arm64-2026.06.04-124517.tar.gz"
    sha256 "9d8fa3ee56650d80bbdc882b490d132e5e894b0561346b5b915f088987807246"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.04-124517/wendy-cli-linux-arm64-2026.06.04-124517.tar.gz"
      sha256 "b3f9e89794d448db8bd5a84290cf67141fe619cd8dc98e73932ab95eaec1d70f"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.04-124517/wendy-cli-linux-amd64-2026.06.04-124517.tar.gz"
      sha256 "b2944b873374f3252124136c4998bf120e8c84d3b82bc31ee1bada79e77d8888"
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
