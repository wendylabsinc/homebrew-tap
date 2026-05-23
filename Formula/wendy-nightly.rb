class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.05.23-155555"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "228d389c0f935b6ee4f37844fff645397c86538aae394f2f410a2f71dd72edb8"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.05.23-155555/wendy-cli-darwin-arm64-2026.05.23-155555.tar.gz"
    sha256 "158e39c61c60591f7c989c718949d8f3e364c43b070ee879b471348cb5528d7a"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.05.23-155555/wendy-cli-linux-arm64-2026.05.23-155555.tar.gz"
      sha256 "56df8b82b17a63cf20f3ecf80f31169bf3f7df46762bc08836facc87156f908f"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.05.23-155555/wendy-cli-linux-amd64-2026.05.23-155555.tar.gz"
      sha256 "764607a5f7deaf35e4c19150cf9ad898fbbe36dadcd3c1861b925ce26eb34830"
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
