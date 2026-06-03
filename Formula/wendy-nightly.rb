class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.06.03-194747"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "0ee97e02e630023420bb1447e71cd17cca5a9ed6d984035b10b8a5954a56fb4a"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.03-194747/wendy-cli-darwin-arm64-2026.06.03-194747.tar.gz"
    sha256 "e6973b1801bcb28b95ee551bb3b63efc7935fe618bbb33487b511c7f4f501dbb"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.03-194747/wendy-cli-linux-arm64-2026.06.03-194747.tar.gz"
      sha256 "f8ddfca887d953441f6bb7cb7155cdd607f55c8c3910158411671e7f8ae47958"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.03-194747/wendy-cli-linux-amd64-2026.06.03-194747.tar.gz"
      sha256 "e780d4b5cbb4fa801040255b76af098e1d94921b0a5d76f5e7d72e659f59c344"
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
