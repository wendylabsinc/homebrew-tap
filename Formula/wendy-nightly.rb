class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.06.11-164151"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "569ec0b8b7bc77246098f9ff626e2b18b968087543f8c371116aac1dfd8accc3"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.11-164151/wendy-cli-darwin-arm64-2026.06.11-164151.tar.gz"
    sha256 "b3bc791ece7eb1d6c2db3cfa446074b6d95454fa4787d7bc4887b08c1fb80369"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.11-164151/wendy-cli-linux-arm64-2026.06.11-164151.tar.gz"
      sha256 "6a02b0e6c1864796b019e36591c8ab0cc92fa7dc4ec7cba25a05ecdc0a5a10a6"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.11-164151/wendy-cli-linux-amd64-2026.06.11-164151.tar.gz"
      sha256 "a326e08f5f2613d6d16348b5c3069b47c19d2958ec9d03ab2b9ec2c929e83fde"
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
