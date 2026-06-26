class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.06.26-085615"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "94c548ec5a7830358ffe7034540ff8d1d2ad2d40788e6f0f9f743e0a66570a09"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.26-085615/wendy-cli-darwin-arm64-2026.06.26-085615.tar.gz"
    sha256 "1fbd8672dbc88b591a57b2b3e4ce79b3b2d4ff8b246d54289e566a4e33fde222"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.26-085615/wendy-cli-linux-arm64-2026.06.26-085615.tar.gz"
      sha256 "1ebf4b13ddfbcbed9aba027af15c02c142c12d0330225a2f2e4be679d5de01aa"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.26-085615/wendy-cli-linux-amd64-2026.06.26-085615.tar.gz"
      sha256 "fb6b6d0f71eac4265f4822d4dd1ac41ec9c3559e69982cbe934f9795e8a016c7"
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
