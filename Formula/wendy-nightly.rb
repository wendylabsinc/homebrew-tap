class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.05.29-050321"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "d0854579520a6307bf5ecbe1bd13b5083ae1e76591a44e312a0e24dc2d49250a"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.05.29-050321/wendy-cli-darwin-arm64-2026.05.29-050321.tar.gz"
    sha256 "480b9dc89085da1d35dddffd999e7ed17f1c2a639389c1158e4d043924752b64"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.05.29-050321/wendy-cli-linux-arm64-2026.05.29-050321.tar.gz"
      sha256 "422ad34c3ee42ab80a7bf358e78bf8e40e78c136a8c42bf7eeb13d4debc3a417"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.05.29-050321/wendy-cli-linux-amd64-2026.05.29-050321.tar.gz"
      sha256 "bd08d3541f5197166b15ce05e4716afd1d3a8514ba37c1bd6ce4c98a16ee281d"
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
