class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.06.18-145157"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "4f40c2245db585d6f4d47287aa6886f47fa24ae99aa63d11a36a5d7c1398b089"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.18-145157/wendy-cli-darwin-arm64-2026.06.18-145157.tar.gz"
    sha256 "1ea6ae70ebe944d102a0ac40d240aa9897b699c8cf4c27fcd918b6eb90589621"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.18-145157/wendy-cli-linux-arm64-2026.06.18-145157.tar.gz"
      sha256 "7d5dd42cc74247f7b7ba44ee5aa3c96382766cc6fa1b9f0e55eb987775664585"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.18-145157/wendy-cli-linux-amd64-2026.06.18-145157.tar.gz"
      sha256 "8acf4eb7683d6b069c7f4b088b1ba8e54192f2cacde1b4b6b42f37387e3e0a48"
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
