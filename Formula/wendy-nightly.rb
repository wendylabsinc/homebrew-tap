class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.06.06-165924"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "691ad078afb3761c10e2f9704bbb0524527949da0935f9c4e7028ce964a0fd2d"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.06-165924/wendy-cli-darwin-arm64-2026.06.06-165924.tar.gz"
    sha256 "275c9d7cf7255c9b8d54fa106e9126c3b6a284a1acf9b9f10d872b9ddc7c6620"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.06-165924/wendy-cli-linux-arm64-2026.06.06-165924.tar.gz"
      sha256 "4238c79b33cbbe909c6b9968e12d4b968e0e5763f8a41c285564a5024798775c"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.06-165924/wendy-cli-linux-amd64-2026.06.06-165924.tar.gz"
      sha256 "0b9b4acce8850332360a37afdd9ade91baaf3b986ba3ad93c0d895facf4e5f26"
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
