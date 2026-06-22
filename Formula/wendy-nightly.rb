class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.06.22-160225"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "65524b8697c3d743b51668772b862d2546af983e24292bebe39a32a9e31af2df"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.22-160225/wendy-cli-darwin-arm64-2026.06.22-160225.tar.gz"
    sha256 "e6483ae18b02da2fac684b0c7267bb95ebba0563842dd569bcbeaa00f59b6e17"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.22-160225/wendy-cli-linux-arm64-2026.06.22-160225.tar.gz"
      sha256 "7ed5089002474c598d4daac9c9ead2793d5f369e5294b828a8d19cd3764ed0b5"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.22-160225/wendy-cli-linux-amd64-2026.06.22-160225.tar.gz"
      sha256 "5470150a8d427614149cf3ed6c005c6c2c87780ded32d7388034f9a6b784cb54"
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
