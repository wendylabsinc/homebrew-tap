class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.05.19-111156"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "b414d32d9bb520031a2d07879b48e71c74937faac98a29442ab71543d6ffc037"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.05.19-111156/wendy-cli-darwin-arm64-2026.05.19-111156.tar.gz"
    sha256 "de5ac210bb4d914fb9b297416892fd6885c48a1295cfb9ac0c75ce77d29d664a"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.05.19-111156/wendy-cli-linux-arm64-2026.05.19-111156.tar.gz"
      sha256 "ed41b8e486ba70ce8b7e779c7b400049975a56b7acecc77901ad7c0970b7a5a0"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.05.19-111156/wendy-cli-linux-amd64-2026.05.19-111156.tar.gz"
      sha256 "4a457c5585c1c10105d1ade43901996eab0eb1a97533b502dfe3a3a63a1969c0"
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
