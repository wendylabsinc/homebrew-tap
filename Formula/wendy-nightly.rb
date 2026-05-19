class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.05.19-090119"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "54bab75c6b4ab52eade7673e09acb1dd1230a69b12b33228738992290797699e"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.05.19-090119/wendy-cli-darwin-arm64-2026.05.19-090119.tar.gz"
    sha256 "36df9d406a07990ccd0f4f9299d7b8b7eada41f3c2b28ddefd11d6a0ad9b3d90"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.05.19-090119/wendy-cli-linux-arm64-2026.05.19-090119.tar.gz"
      sha256 "978acfb16cff42730d8026c0426cbe54752874277f3faa6fa42363b3d9c068d6"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.05.19-090119/wendy-cli-linux-amd64-2026.05.19-090119.tar.gz"
      sha256 "28b2502ce26a54f8c5f9f4f71487441be3b179e074120c1591d7d2afef81a2d3"
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
