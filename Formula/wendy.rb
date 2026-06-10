class Wendy < Formula
  desc "CLI for building and running WendyOS applications"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-2026.06.10-142200"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "ed31f6291aa422423e19f9732cf022cc4c34bf2c36e3bfc87e8a7e7a71807dd1"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.10-142200/wendy-cli-darwin-arm64-2026.06.10-142200.tar.gz"
    sha256 "bbe394f7d60f418c418b213bfecb81a16a9feab585f1fb014405d8caa445ee9c"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.10-142200/wendy-cli-linux-arm64-2026.06.10-142200.tar.gz"
      sha256 "49d6ed12ca57f250338f47fa511eb9f16017fc0f48e32e2eb195e4f932cb87f1"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.10-142200/wendy-cli-linux-amd64-2026.06.10-142200.tar.gz"
      sha256 "5056c14b9417658e2961bae45b78c8770926ca3b0879c1a71daed7465c46f815"
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
