class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.06.09-111506"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "36bd94a1b95940f2ea18770a57d4b7911df6dca5ce8e7b12aa9dba99cae7c3b8"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.09-111506/wendy-cli-darwin-arm64-2026.06.09-111506.tar.gz"
    sha256 "0768be6447ca69de6c97e4fce9527d12621878d80a7ed7d47d9b253d6fe18fe0"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.09-111506/wendy-cli-linux-arm64-2026.06.09-111506.tar.gz"
      sha256 "62e863eb23a4731373717ad1bdf1264e1fd4db6cd2184e4c2f5cc9b7a63043ed"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.09-111506/wendy-cli-linux-amd64-2026.06.09-111506.tar.gz"
      sha256 "ca72ab7676e5d99b0e134b6cea87dac5bb64649ba6381962612b3bad864bd077"
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
