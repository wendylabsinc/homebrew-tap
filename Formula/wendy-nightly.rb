class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.06.03-055659"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "a3416ca9b9863f8128d1952be6240b594609089184d54d6f97bd04cc88b28a7c"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.03-055659/wendy-cli-darwin-arm64-2026.06.03-055659.tar.gz"
    sha256 "705e3fdf57f1f5c58b5741d13481d9e472f3fd864fc5280e0caac33b37388b91"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.03-055659/wendy-cli-linux-arm64-2026.06.03-055659.tar.gz"
      sha256 "a897254465be41955c0d24232a4896f59a72652ad728f5cd950c8b1171f4e79d"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.03-055659/wendy-cli-linux-amd64-2026.06.03-055659.tar.gz"
      sha256 "d383689b201351025d244de0b7107090672ff99282aaa88e85f383ff9cf1ed7c"
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
