class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.06.17-151132"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "f5a52faffab3c3121783d2f603a0856df39c6cf72d878a61d08a3dbc1212181c"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.17-151132/wendy-cli-darwin-arm64-2026.06.17-151132.tar.gz"
    sha256 "8ee8021041c52e6e74a150cbb0aff245d1e4bf479741bb41e8d1508df1a1d9f2"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.17-151132/wendy-cli-linux-arm64-2026.06.17-151132.tar.gz"
      sha256 "49e0fe3d427f72ae5b999617701eb93e22bd2d9ea6e1fff35edfad59a4f53d23"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.17-151132/wendy-cli-linux-amd64-2026.06.17-151132.tar.gz"
      sha256 "fd6ce85170322b167643856cc965c34a78c53e1cc82b4bee994507ee861e5dde"
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
