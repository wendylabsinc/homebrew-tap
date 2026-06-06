class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.06.06-105817"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "ec517140dcb9c3a4607be4e979bdd6f7c8cb8be06de405792858fbf2738e61bc"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.06-105817/wendy-cli-darwin-arm64-2026.06.06-105817.tar.gz"
    sha256 "8cfbd818d9fbe635c9b125b3e53dc4e133248ae2ade898e9686c5f6428bfbe2e"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.06-105817/wendy-cli-linux-arm64-2026.06.06-105817.tar.gz"
      sha256 "d2a3d893494667dbcbddc175f0439876b7a6a94bce761d9494b6009fbdb8e696"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.06-105817/wendy-cli-linux-amd64-2026.06.06-105817.tar.gz"
      sha256 "6d9e146b2f5010a11af6102c272efcf63b4eb8431ae6c89a75510f78eef4a36a"
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
