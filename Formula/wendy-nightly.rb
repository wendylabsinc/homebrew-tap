class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.06.11-213924"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "ba32f561099b3d011351031acb25f49557e9eeaaf5f21589ff8bcf3bec8ac991"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.11-213924/wendy-cli-darwin-arm64-2026.06.11-213924.tar.gz"
    sha256 "3c2ef5c5b8b8a7b7ea06c5d8c961c7ddf032b69ff7a400aeedd6df5745cad67a"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.11-213924/wendy-cli-linux-arm64-2026.06.11-213924.tar.gz"
      sha256 "bb8bc761d146fcc91e67fcecc422b283ef4b5a64cfc983d81fec2ae4474d6047"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.11-213924/wendy-cli-linux-amd64-2026.06.11-213924.tar.gz"
      sha256 "8c1d862a13a640c1262570126ba85f8430c06cb71332d0c8154b4d0edd6581bb"
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
