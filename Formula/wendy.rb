class Wendy < Formula
  desc "CLI for building and running WendyOS applications"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-2026.05.31-060504"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "83be9c30fa97d69e9579ffe7773f05a528232f40341bcabf12e741c917858463"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.05.31-060504/wendy-cli-darwin-arm64-2026.05.31-060504.tar.gz"
    sha256 "984ef02c194630337f78a22d08c40b74227d91d477328ef2cbf366b26a0a91ec"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.05.31-060504/wendy-cli-linux-arm64-2026.05.31-060504.tar.gz"
      sha256 "58d6c9c6ec0b65ce49bdb68fa07c6599a8293ea89ae66e3a49f0f5e5661fe75f"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.05.31-060504/wendy-cli-linux-amd64-2026.05.31-060504.tar.gz"
      sha256 "8064e8fef78a4207ce4cc0359e50560636bf3f36de8481e82186b58ef358c3c8"
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
