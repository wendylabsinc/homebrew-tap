class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.05.22-182247"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "bf24ddfb78f4493822854164043e66abcb6fbc3735e30841d8a28f44d8d2a863"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.05.22-182247/wendy-cli-darwin-arm64-2026.05.22-182247.tar.gz"
    sha256 "a6c29d8bd5846b095b8f8cb678a32e8578c3510c7ac0ab5580e68314b5e9737a"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.05.22-182247/wendy-cli-linux-arm64-2026.05.22-182247.tar.gz"
      sha256 "b1398eb9e9750e15e79549e195d0c9f8a36f347760b9379008d7337c6f23db64"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.05.22-182247/wendy-cli-linux-amd64-2026.05.22-182247.tar.gz"
      sha256 "603e454d473a61ad586597e0c2bf7387bd3cbc8fec728ace105f699add1f68ec"
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
