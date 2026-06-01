class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.06.01-034659"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "0ce24165d45c74395162c6e1162bcfcdeadef77640bd7d280eb32d389e2f985e"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.01-034659/wendy-cli-darwin-arm64-2026.06.01-034659.tar.gz"
    sha256 "ee1c6d5bb410a9c0431d8a2603c42cceddcf729cddde024104686edc06069aca"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.01-034659/wendy-cli-linux-arm64-2026.06.01-034659.tar.gz"
      sha256 "ef2e718b373587ec7bf97aaced459ae743ccc150c096f9943cc904cb38feb80a"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.01-034659/wendy-cli-linux-amd64-2026.06.01-034659.tar.gz"
      sha256 "f567b9de8989304c4256cd5bb1902e542c392edb17ab5e7bc07e6bdff0e6097d"
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
