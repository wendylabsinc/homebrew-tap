class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.06.07-123437"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "0474b9a95a5acdb83cee9b5c2fc0fdbc55461812ae27c4ca2821012f894b7592"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.07-123437/wendy-cli-darwin-arm64-2026.06.07-123437.tar.gz"
    sha256 "37233b832f10793e71ffa6c1fa81df5e3ebba764c05eaf21977cb6962c2e3bc6"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.07-123437/wendy-cli-linux-arm64-2026.06.07-123437.tar.gz"
      sha256 "f2f75f69b3f2dfba366a58d87b13702a98a9b64754b4b0c825fcc50acf842d74"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.07-123437/wendy-cli-linux-amd64-2026.06.07-123437.tar.gz"
      sha256 "48391e1b43b869300033d033919bfe8ac833c002ee2bc00beff495ec6249568f"
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
