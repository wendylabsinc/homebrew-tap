class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.06.27-171712"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "55bb40e0fee3f50c1fbe54bc84551e414992a5f23d0024c4ef14140fd498848e"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.27-171712/wendy-cli-darwin-arm64-2026.06.27-171712.tar.gz"
    sha256 "5d61f6f1c3425b67e99a9d03cf868d21758ea54a1c2c06e188baf003ead7b3ca"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.27-171712/wendy-cli-linux-arm64-2026.06.27-171712.tar.gz"
      sha256 "813ec9737c301a35850bd21a9fb2642d59370eb95a2a5ee37e0992a2d3cf214c"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.27-171712/wendy-cli-linux-amd64-2026.06.27-171712.tar.gz"
      sha256 "a3529755941a1c08777d3fcdee239dd1bb19a1ab101b722bc6415af839aa36e5"
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
