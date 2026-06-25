class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.06.25-150927"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "a1530e22cdf08d1b21cb4a660efef24d67dea60c1a27be7983804e775f9d57dc"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.25-150927/wendy-cli-darwin-arm64-2026.06.25-150927.tar.gz"
    sha256 "92b729e8246bed4337ef1d74af7876cfc70de63db8b8c2c121b98aab9571827b"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.25-150927/wendy-cli-linux-arm64-2026.06.25-150927.tar.gz"
      sha256 "7dc58771c0603a2d03c1badd96b3b39b7acf517efe65744aacb4eab414d30312"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.25-150927/wendy-cli-linux-amd64-2026.06.25-150927.tar.gz"
      sha256 "344662602e5c7edf3e0f507bb150f42d30b798ab96b587a69728c0ddb6af7ec3"
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
