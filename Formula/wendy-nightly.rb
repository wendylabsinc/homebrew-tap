class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.06.25-145618"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "6eae314c2defaea3848e9cb1ba15c4b979856af3d0ccc3a3fe381f5d5f734f71"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.25-145618/wendy-cli-darwin-arm64-2026.06.25-145618.tar.gz"
    sha256 "76a6e1cd03980b02ece5883fcc954c4ac6867ce1c4fa4a8dc93c40c48a37ce87"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.25-145618/wendy-cli-linux-arm64-2026.06.25-145618.tar.gz"
      sha256 "6a799b37a317151ed29df0c78cbcc6afb00013f8a1ffe6de8843bd2b80c8bc9c"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.25-145618/wendy-cli-linux-amd64-2026.06.25-145618.tar.gz"
      sha256 "1f7e0587fdb188a10eb0f0062578ca103092482190f5e289292e63102cd8c75f"
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
