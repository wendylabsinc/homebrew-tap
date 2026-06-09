class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.06.09-145030"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "281fd8bb7da39ae4cda95c89a585064922f7b4b2c352b2ea179d4a5591d23e7b"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.09-145030/wendy-cli-darwin-arm64-2026.06.09-145030.tar.gz"
    sha256 "c63eeaaab8890470c2e9ddcbc224cfdaa96e8e63482a076d7f1e9965fe55fe43"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.09-145030/wendy-cli-linux-arm64-2026.06.09-145030.tar.gz"
      sha256 "f6d3a9a693f18ee5d6f86ead976a032f01bdb6b8322ed0a9dc9f543f91ed6222"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.09-145030/wendy-cli-linux-amd64-2026.06.09-145030.tar.gz"
      sha256 "cd36ff6e77cedbc4a0a9f99296a55024124cda64eb15ce8bc679f74a9bcb5d86"
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
