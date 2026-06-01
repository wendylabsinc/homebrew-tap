class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.06.01-023937"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "e7f1fc37d0a840c9dae55c5ba6dc3f2aecb9529bb598cd78110f76bcf6e293d9"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.01-023937/wendy-cli-darwin-arm64-2026.06.01-023937.tar.gz"
    sha256 "feca84d197559b9515fd08df423d163301a1c37bb9b66f3718d84d31b34b0216"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.01-023937/wendy-cli-linux-arm64-2026.06.01-023937.tar.gz"
      sha256 "216dfdc3c0b1191b5fcb6c64131f3fe45a5b2ac460b47d34b04056f3cd499429"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.01-023937/wendy-cli-linux-amd64-2026.06.01-023937.tar.gz"
      sha256 "f3cfffb5d38ba762abb178df8997d753b21b32f85d1517ecf0e3a23a0bed40ae"
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
