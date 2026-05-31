class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.05.31-191107"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "1e8e16984dfd152de6f762d6ddf8fc503098e478e386e321c46a696b030e3bc3"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.05.31-191107/wendy-cli-darwin-arm64-2026.05.31-191107.tar.gz"
    sha256 "07fb47525274c62791fd5cc0512930f136a74a77d395939a637e10656f0b0f7e"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.05.31-191107/wendy-cli-linux-arm64-2026.05.31-191107.tar.gz"
      sha256 "4c8dce2e3c8a07cd2d061ff286d4f285e678e6487bb3fc158f5d977da516c56c"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.05.31-191107/wendy-cli-linux-amd64-2026.05.31-191107.tar.gz"
      sha256 "5588b0f97bc202dfd1739965dd596ec1361a4a1147cd13b72ce078f246ea43d0"
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
