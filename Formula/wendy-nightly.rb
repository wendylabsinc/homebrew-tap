class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.06.27-193417"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "0262b469ce71997c41ab34bedac06fa3418d92aefcbe6c14306f88b194585356"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.27-193417/wendy-cli-darwin-arm64-2026.06.27-193417.tar.gz"
    sha256 "9ef7797aaa90a23e00f2b0debd9f77b3910bfb83e44892df17a07b390d6ea50c"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.27-193417/wendy-cli-linux-arm64-2026.06.27-193417.tar.gz"
      sha256 "c563ed8aac18958cafefbb8d330d3bbc2c6426f7a2bea11fa7476bb41e926abd"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.27-193417/wendy-cli-linux-amd64-2026.06.27-193417.tar.gz"
      sha256 "4651d24f10d480a1ca50a3adf730f32cad2316470ff6e52e56547d5c77f2db84"
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
