class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.06.27-214307"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "56c1c22c274a1ae693207af599769b186b57e2f403f64e94ff2d3b8069a0872e"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.27-214307/wendy-cli-darwin-arm64-2026.06.27-214307.tar.gz"
    sha256 "170a21006681f008880032ca4bec68c69d04164ee87f9200c69c8c86e6075ddb"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.27-214307/wendy-cli-linux-arm64-2026.06.27-214307.tar.gz"
      sha256 "49ba3c5cd7cc51e05fb08796be9c0a98723184660237ef51200b21319f9a82bf"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.27-214307/wendy-cli-linux-amd64-2026.06.27-214307.tar.gz"
      sha256 "33f5a8166744b99a64fdd910242a092d541fb96a549b52bc16601135a41387df"
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
