class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.06.09-114217"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "36bd94a1b95940f2ea18770a57d4b7911df6dca5ce8e7b12aa9dba99cae7c3b8"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.09-114217/wendy-cli-darwin-arm64-2026.06.09-114217.tar.gz"
    sha256 "e316710b5a2c7b3d2558fc1c218a44113a8ff3254173cd1d30ca70afa0fb82e2"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.09-114217/wendy-cli-linux-arm64-2026.06.09-114217.tar.gz"
      sha256 "07fc2a6c5c7d321e0d598758c96a152b20c3fff69aaba119fdf5bb02d5434d7d"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.09-114217/wendy-cli-linux-amd64-2026.06.09-114217.tar.gz"
      sha256 "2f57827ea6a5bf4f985d43b386469e9bb79c276033066f537fb164c4a2d04265"
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
