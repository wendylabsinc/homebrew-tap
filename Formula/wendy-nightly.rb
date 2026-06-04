class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.06.04-214249"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "1f204985b78a1e041ef3daefb34904ee3db4e8dab06fb8c0665d2413a8a237ff"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.04-214249/wendy-cli-darwin-arm64-2026.06.04-214249.tar.gz"
    sha256 "ef417b81ae95d69e4e9027ec7ffa15e2470d784e90bed4043f05e42934879504"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.04-214249/wendy-cli-linux-arm64-2026.06.04-214249.tar.gz"
      sha256 "8c777565706e9ca2bc744c9403a78fd215ec2f025cf6fa595a451116aae1e391"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.04-214249/wendy-cli-linux-amd64-2026.06.04-214249.tar.gz"
      sha256 "b724ba53939ae75100166466c9b4324767762f8d431948b9bb2ea0916c575fd2"
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
