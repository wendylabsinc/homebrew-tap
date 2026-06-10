class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.06.10-112219"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "0b2ea361d2276092b56253f8ee7864125fda27046fac02604e52d597c806403a"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.10-112219/wendy-cli-darwin-arm64-2026.06.10-112219.tar.gz"
    sha256 "7307798310c1912017c4526efd70a5fa478296c1c6c24e37a2e4460df0dfaf5e"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.10-112219/wendy-cli-linux-arm64-2026.06.10-112219.tar.gz"
      sha256 "120096cdecb3ec062c6834cedc0ba6b97fb370d9edc9c0660c77d4aa4ab1c9c7"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.10-112219/wendy-cli-linux-amd64-2026.06.10-112219.tar.gz"
      sha256 "e730d60f66ebf1bf7d6f8f189dc9184cbfed11f2420019233fbcb97efc49ecb0"
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
