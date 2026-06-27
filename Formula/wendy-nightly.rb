class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.06.27-134050"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "055c4493407378548f84a77b6e3b54b254631306340e6b2aa273416f0ac1b971"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.27-134050/wendy-cli-darwin-arm64-2026.06.27-134050.tar.gz"
    sha256 "89c9278d247f2ffdc5ed25dd3a2c8e4621c05565e5735325d05046ba65d09c0c"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.27-134050/wendy-cli-linux-arm64-2026.06.27-134050.tar.gz"
      sha256 "d3370e54941e44fe8344070ebee814d2f674634a9b3da80651ab1601909b2dab"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.27-134050/wendy-cli-linux-amd64-2026.06.27-134050.tar.gz"
      sha256 "fec37f8131d6b9b6e83574d6d86e4faad4e3792746e1b2c72920a92d620fdc3e"
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
