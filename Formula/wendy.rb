class Wendy < Formula
  desc "CLI for building and running WendyOS applications"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-2026.06.12-113052"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "d87f6a359717e521ba55d73876711455eb8821e9496c337d20b99b82215431e3"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.12-113052/wendy-cli-darwin-arm64-2026.06.12-113052.tar.gz"
    sha256 "68c27c0487c76352ef92262b243fb1f82e67fe10b3117dd6258e5618e9625f80"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.12-113052/wendy-cli-linux-arm64-2026.06.12-113052.tar.gz"
      sha256 "c5d75e4d0693207d4d18eefa386f3f9b7f6422039119ce7cfcc56099ef5c407a"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.12-113052/wendy-cli-linux-amd64-2026.06.12-113052.tar.gz"
      sha256 "44114c49e8f4271f41379612be1286533b6b37f9d47e62db5e04c7a41f44b0b6"
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
