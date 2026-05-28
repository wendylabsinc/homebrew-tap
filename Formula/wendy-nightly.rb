class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.05.28-061552"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "c02f0102d5b61bef4cff8099c68d7d030612899d4d4cb9bc8f2d978b2fc99dbc"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.05.28-061552/wendy-cli-darwin-arm64-2026.05.28-061552.tar.gz"
    sha256 "e254b3377bc233b4a9f39841c8b5a631aba0cdf766757aba46dcfe5d0f2dac70"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.05.28-061552/wendy-cli-linux-arm64-2026.05.28-061552.tar.gz"
      sha256 "5f19788783dc898fe952e477c98327d528a3e108c9da9396dcb428a05d732865"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.05.28-061552/wendy-cli-linux-amd64-2026.05.28-061552.tar.gz"
      sha256 "4c14a92099e5fbbebfe2fd54afd9bd0b9e203790341488aaa21abcd5f41da903"
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
