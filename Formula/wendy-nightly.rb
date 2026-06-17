class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.06.17-173150"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "f5a52faffab3c3121783d2f603a0856df39c6cf72d878a61d08a3dbc1212181c"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.17-173150/wendy-cli-darwin-arm64-2026.06.17-173150.tar.gz"
    sha256 "acfca2ec14b546b14567fd82cbb67a2f6266b88584935d36b50997b72e69daec"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.17-173150/wendy-cli-linux-arm64-2026.06.17-173150.tar.gz"
      sha256 "f614514ded23d8e61d446c483c27f57a11f74120db7d023e5de9110d987a49d0"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.17-173150/wendy-cli-linux-amd64-2026.06.17-173150.tar.gz"
      sha256 "2912e17d5b18f828bc01c45a4202cd361b63758a28d4c947b982a81c9033e7e6"
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
