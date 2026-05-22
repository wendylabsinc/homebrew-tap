class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.05.22-201747"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "e79da9ba6ca0e8695580f9670996fea6d73d59077a9b76ed64034d9f3c113c48"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.05.22-201747/wendy-cli-darwin-arm64-2026.05.22-201747.tar.gz"
    sha256 "5db4c5d35179cf43eb1a488063245c89e2878c777f71ee1333b993f185a02b45"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.05.22-201747/wendy-cli-linux-arm64-2026.05.22-201747.tar.gz"
      sha256 "944a55b4657dde17aeaf9b8f7930c4cb28b8e63083689a5c054446dc33b124ce"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.05.22-201747/wendy-cli-linux-amd64-2026.05.22-201747.tar.gz"
      sha256 "d65ab762f6d46db8a5a3f8ed1d75071341c66ed27b0d8c8c0313b544c9ce054c"
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
