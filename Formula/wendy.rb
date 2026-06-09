class Wendy < Formula
  desc "CLI for building and running WendyOS applications"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-2026.06.09-034757"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "6433b0d6ca7269e8d0439b4dbc2affa03a5f8abf069727a2dcd0e9b55fa7d240"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.09-034757/wendy-cli-darwin-arm64-2026.06.09-034757.tar.gz"
    sha256 "9266609d20b79a8a27c76f8247c0148d08f08b49778ec31e47e9ef45936bcd66"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.09-034757/wendy-cli-linux-arm64-2026.06.09-034757.tar.gz"
      sha256 "8d2ded556764f7ae001f9c6a8e937e8522715ebe48fe8ec0713f2b4ac1965bea"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.09-034757/wendy-cli-linux-amd64-2026.06.09-034757.tar.gz"
      sha256 "3e749fb766342612ca903f43cb2c525658fc95b4d6a36a42145a80a75e927917"
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
