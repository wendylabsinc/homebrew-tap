class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.06.07-175506"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "52614ae236e47bd0c8600e28e752ae062db201fdcf0b91e6d9e2e1cae5e56cff"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.07-175506/wendy-cli-darwin-arm64-2026.06.07-175506.tar.gz"
    sha256 "42c4a48f12f3ce4bdbbf1b8bc9cfd1a9c8aa9cec2b29a3c90e52be829ead76f0"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.07-175506/wendy-cli-linux-arm64-2026.06.07-175506.tar.gz"
      sha256 "b85d5a376eeed80b64d7f71922b59269b34d249cccc027ca9905847829570b5d"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.07-175506/wendy-cli-linux-amd64-2026.06.07-175506.tar.gz"
      sha256 "f5b7405ec3ebc2fd96caceb8242889102f018b5317a5f6880ca3696aba4ea999"
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
