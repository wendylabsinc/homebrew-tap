class Wendy < Formula
  desc "CLI for building and running WendyOS applications"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-2026.06.01-031953"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "78124d85cbbf6894d933b255bf9931a814a2d7f580b2d48dc5ba249d373ffec4"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.01-031953/wendy-cli-darwin-arm64-2026.06.01-031953.tar.gz"
    sha256 "f46ee9b4f1608e667d69d23e2b1732d323830068f0ee0c9d2e8ee12bf7c0846f"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.01-031953/wendy-cli-linux-arm64-2026.06.01-031953.tar.gz"
      sha256 "2b444951cc54d8125a0f2bba99bc37655ad777753ecefca831e8d57aaac58bed"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.01-031953/wendy-cli-linux-amd64-2026.06.01-031953.tar.gz"
      sha256 "176c3acf571eb857eca2ef8b4dd8b7f60913e7d7330639b51ccc77f9d9415243"
    end
  end

  conflicts_with "wendy-nightly", because: "both install a `wendy` binary"

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
    # TODO: It would be better to actually build something, instead of just checking the help text.
    system bin/"wendy", "--help"
    assert_match "wendy [command]", shell_output("#{bin}/wendy --help")
  end
end
