class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.06.11-222624"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "3c8ebdbe5fd215d006a4130b28528dc2c58a0c9e792ee0ff6741827444bf43a6"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.11-222624/wendy-cli-darwin-arm64-2026.06.11-222624.tar.gz"
    sha256 "1a0e4b18329467957922bf761ba5b3d514269ca107fd7f3a9d7c848b1f8bc827"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.11-222624/wendy-cli-linux-arm64-2026.06.11-222624.tar.gz"
      sha256 "72073522eec69112c9b3e5af44d9f7e2e632ebc95e782add68b356d1f9d48d5f"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.11-222624/wendy-cli-linux-amd64-2026.06.11-222624.tar.gz"
      sha256 "9927e72ef1aa41d766274de59ace67161e5bed8ff673d016a8b07d235dafbdbe"
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
