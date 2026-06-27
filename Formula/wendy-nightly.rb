class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.06.27-233704"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "a050a6d85a26165fdae922a6b1b15f64e2eda170b278f7d30630f5bebd27aa68"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.27-233704/wendy-cli-darwin-arm64-2026.06.27-233704.tar.gz"
    sha256 "79ea412784825b93d81726756903528449a6830bbe95741da34e3c3bb59c714c"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.27-233704/wendy-cli-linux-arm64-2026.06.27-233704.tar.gz"
      sha256 "db7fe6b3cda59e3853d67c9b0837cb6039a7a1aa923de046951ef09014021253"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.27-233704/wendy-cli-linux-amd64-2026.06.27-233704.tar.gz"
      sha256 "65e4231e676dd1b9f068ce342da82818cf3ec5b8f029d219b53187f2e29ecc31"
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
