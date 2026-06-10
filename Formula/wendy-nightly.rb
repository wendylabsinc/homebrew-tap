class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.06.10-083808"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "0b2ea361d2276092b56253f8ee7864125fda27046fac02604e52d597c806403a"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.10-083808/wendy-cli-darwin-arm64-2026.06.10-083808.tar.gz"
    sha256 "727815159148c276e5cda738a133939b4382dbc7998558b444fb7814bb4c953a"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.10-083808/wendy-cli-linux-arm64-2026.06.10-083808.tar.gz"
      sha256 "bc4a81a6ae3078ab7837c34695679de499aa6b90d72556447b1c4a2439d7d771"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.10-083808/wendy-cli-linux-amd64-2026.06.10-083808.tar.gz"
      sha256 "eb3dc2b7af3d01cacec90b54883e7001143cc7c50a48efe043b3e1f67e48f101"
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
