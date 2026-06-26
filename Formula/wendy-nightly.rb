class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.06.26-080245"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "cec039b275f29181ce838c30d913f964c98726b25f86fcf5cb52b7b661260383"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.26-080245/wendy-cli-darwin-arm64-2026.06.26-080245.tar.gz"
    sha256 "2ac5b2b019d41ee5370d2bc322fd3132ad90788d12d6ec9c94eefe7802d3f346"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.26-080245/wendy-cli-linux-arm64-2026.06.26-080245.tar.gz"
      sha256 "d293d9dfc632baea60bda16ed623aa751b629dc91e420c7588a6684d931ef54c"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.26-080245/wendy-cli-linux-amd64-2026.06.26-080245.tar.gz"
      sha256 "f2163c777b776ec73cb5939a571ad5636b047f02373cf9780e5991fc6766b09a"
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
