class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.06.22-140229"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "15382d9860304d101fcb3ead156584aa7dbaf754df2c9d16cf3cdea40dbd7030"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.22-140229/wendy-cli-darwin-arm64-2026.06.22-140229.tar.gz"
    sha256 "9a4821b7f7600d4b0a64ffb8ff4163e3cda29832a7f95be5d2bffe30fd670990"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.22-140229/wendy-cli-linux-arm64-2026.06.22-140229.tar.gz"
      sha256 "6416793f2f07a2c5b524e3f77bc3a200b76d4e70caef701b7f31f0e7284ad8b3"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.22-140229/wendy-cli-linux-amd64-2026.06.22-140229.tar.gz"
      sha256 "b7cb7773269ee1d53476a38f453f9866183dcca43f4a7a987da8e0c485cb8b8a"
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
