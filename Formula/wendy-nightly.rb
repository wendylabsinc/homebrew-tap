class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.06.27-203254"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "c7095175589ad49762a50eec0e5cef71514ebb0486e45280ef1d3bd2866c8f75"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.27-203254/wendy-cli-darwin-arm64-2026.06.27-203254.tar.gz"
    sha256 "28fb7f9fa781ff93bfd355bd545ac9cb971b47884fdf957b5b1da90466f10615"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.27-203254/wendy-cli-linux-arm64-2026.06.27-203254.tar.gz"
      sha256 "2fe3d221c71556db53d5d1c2b5858abf1a22c86c92404640b60b78951530015a"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.27-203254/wendy-cli-linux-amd64-2026.06.27-203254.tar.gz"
      sha256 "3c07a679ea30d69badcd4169b875334cc720b1799fa9e63fe523b3b4cfba197b"
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
