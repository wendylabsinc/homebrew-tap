class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.06.11-153928"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "6efd233965c62045610ece3f6516a0782eab6a368cd2fe101780cc9b1313120d"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.11-153928/wendy-cli-darwin-arm64-2026.06.11-153928.tar.gz"
    sha256 "a77cfb65c1b57a608b0714664e48d1a922709d0fabec8b359d98ffb42270a703"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.11-153928/wendy-cli-linux-arm64-2026.06.11-153928.tar.gz"
      sha256 "956d811706edff58f67c86465f7cfd07de6cf9716d06632bacd3ad2ae5909c95"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.11-153928/wendy-cli-linux-amd64-2026.06.11-153928.tar.gz"
      sha256 "72fb6eb111e3b2ea0e03e475432c3f23099bfd8d12e1cab9e567e4499f0bbabf"
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
