class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.06.20-164816"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "029d9044ccc71cd7519825299cdb16925c2ec1ac8519b57787aae2d2a83b68c0"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.20-164816/wendy-cli-darwin-arm64-2026.06.20-164816.tar.gz"
    sha256 "15bbb8ca6196ebb753f8b356eeb50867dab825ba12553796820e255cdc07d2e7"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.20-164816/wendy-cli-linux-arm64-2026.06.20-164816.tar.gz"
      sha256 "5d528fcdcfae8460db056defee2638febf3fa5793135d1f7fb8a2760c053e266"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.20-164816/wendy-cli-linux-amd64-2026.06.20-164816.tar.gz"
      sha256 "f7a3977f6ddae871f1ffe53577a6c6cf7f60a324085dd51ec3d17f544ab8d071"
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
