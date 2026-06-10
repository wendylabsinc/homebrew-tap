class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.06.10-141039"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "ad42d43ec263bddde68cd6aa4b452b20a9245195fb0c75ac2f324dae1b88974a"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.10-141039/wendy-cli-darwin-arm64-2026.06.10-141039.tar.gz"
    sha256 "6e76834502930445bed99487c22263eaa8987c8cf877cefd1bbb755024f56863"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.10-141039/wendy-cli-linux-arm64-2026.06.10-141039.tar.gz"
      sha256 "3a343f5d280cbc697cee2eccdb3d23aed04958c62ff2b9e1c39b6babd765488b"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.10-141039/wendy-cli-linux-amd64-2026.06.10-141039.tar.gz"
      sha256 "c268551d1f702de6d6cf313eab8ff5c24014b1c23356b3ee29f8059e3ee6a100"
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
