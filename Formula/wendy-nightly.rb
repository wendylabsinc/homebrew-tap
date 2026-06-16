class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.06.16-202159"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "5c30724502b97f98a24de83bf644d4a12770ad24f8aa886ab9a0edc3f687f5be"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.16-202159/wendy-cli-darwin-arm64-2026.06.16-202159.tar.gz"
    sha256 "13a8a59289a27bddd4677b04e66e3ab1081257bf38769c630ec5f5e8315040c5"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.16-202159/wendy-cli-linux-arm64-2026.06.16-202159.tar.gz"
      sha256 "f9b3639aeedc916cbd8355cbae4f1a5f7de5060a2149a69c504fbb5e16f57730"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.16-202159/wendy-cli-linux-amd64-2026.06.16-202159.tar.gz"
      sha256 "dd031564dfdc703fd8f16baf72851e071e0b7201729226343b7bb54f3936e84c"
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
