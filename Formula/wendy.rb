class Wendy < Formula
  desc "CLI for building and running WendyOS applications"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-2026.06.04-163109"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "5d7a1fb7e7c7426d9ad100e983908773a6bf5193bd302148eeb4ca74ca9c42eb"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.04-163109/wendy-cli-darwin-arm64-2026.06.04-163109.tar.gz"
    sha256 "9be0812ff3e2f3e7645fdfecbadd1a345afa7f44eb97820e0a40d2bddca5bb88"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.04-163109/wendy-cli-linux-arm64-2026.06.04-163109.tar.gz"
      sha256 "7ac58690acf08dcdb7c31cd25e9ebfa21cb55df72a793fbe59153590119284ab"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.04-163109/wendy-cli-linux-amd64-2026.06.04-163109.tar.gz"
      sha256 "43b501649f689bb7a3b06fb3b46c7b3305b65d6b9134f4e2df51ab9612333d6f"
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
