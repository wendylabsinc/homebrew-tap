class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.06.22-162402"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "82cb89521c63514f45e68f5152a4dce760f5a1c807f32aa0680fd7f5d7bb0e44"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.22-162402/wendy-cli-darwin-arm64-2026.06.22-162402.tar.gz"
    sha256 "25c9fb302f93b181eb72a55d9a98aa35e071b06734d418f538869d4dce52330a"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.22-162402/wendy-cli-linux-arm64-2026.06.22-162402.tar.gz"
      sha256 "983a5f30f80a5f37d4e6fe713f209bb6d55fa4e82d82675270426b6a17754f0a"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.22-162402/wendy-cli-linux-amd64-2026.06.22-162402.tar.gz"
      sha256 "963d715d78bafc7595a35815479b067286c6e7f094552880b0fb7d02812eddee"
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
