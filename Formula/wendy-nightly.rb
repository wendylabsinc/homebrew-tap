class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.06.20-091348"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "814b117233866fcecc10a384ef02a6df285c40f854a0bc3763a41504a37f35a7"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.20-091348/wendy-cli-darwin-arm64-2026.06.20-091348.tar.gz"
    sha256 "f1cb14934fba7d52f157b377a0c02697cf2906723ac68199a84c7c6ef7c10003"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.20-091348/wendy-cli-linux-arm64-2026.06.20-091348.tar.gz"
      sha256 "f341fb88fbf02b31c5e6253a89d817c3a04e41576a642ad26250799af64f8c3a"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.20-091348/wendy-cli-linux-amd64-2026.06.20-091348.tar.gz"
      sha256 "bf09971e7b2a20c6369262a069cb43bbbb4b42e50fbce675c7de532c90b9ac59"
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
