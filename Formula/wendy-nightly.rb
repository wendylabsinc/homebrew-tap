class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.06.05-165008"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "90c1b42502b7c332edac3f87557916785c09fe924eb79da5a3409e41abf7af84"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.05-165008/wendy-cli-darwin-arm64-2026.06.05-165008.tar.gz"
    sha256 "cb340d293358b379adc9898a4a7be2b21b9a54ac822376a1b21544da285807f8"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.05-165008/wendy-cli-linux-arm64-2026.06.05-165008.tar.gz"
      sha256 "35c42c66bfc20eb561e8e84b674ed034638162958950d5a50ec4135b8bb953f1"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.05-165008/wendy-cli-linux-amd64-2026.06.05-165008.tar.gz"
      sha256 "31ba6f5eefcdd3298e619bde0c5f3e6cdb2c71839b8dcbcff89e8d8857bc3c3c"
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
