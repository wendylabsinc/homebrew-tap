class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.06.27-221534"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "a050a6d85a26165fdae922a6b1b15f64e2eda170b278f7d30630f5bebd27aa68"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.27-221534/wendy-cli-darwin-arm64-2026.06.27-221534.tar.gz"
    sha256 "176e918ae7648ff6768c5d3621f9381b2be6c7604b846098b5202ab3cf6e4227"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.27-221534/wendy-cli-linux-arm64-2026.06.27-221534.tar.gz"
      sha256 "c184f8cc0a0c46f9ced6b37833bd9b9d50980cea666789795433c897f3e32720"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.27-221534/wendy-cli-linux-amd64-2026.06.27-221534.tar.gz"
      sha256 "e4edd51ee75723724e6301c98fcc53ca7803cdec3c257115990aa2b9c1c43235"
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
