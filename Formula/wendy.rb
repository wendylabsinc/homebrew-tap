class Wendy < Formula
  desc "CLI for building and running WendyOS applications"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-2026.06.06-232448"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "8f5892f832d90d97f02eb4b4d11103c55c28cdd701ac4e3194a9fed432eaa627"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.06-232448/wendy-cli-darwin-arm64-2026.06.06-232448.tar.gz"
    sha256 "2db2387e5d3438e2ad72250b96bc40b8b4071d2c7ed5f4de8c98d136871b8014"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.06-232448/wendy-cli-linux-arm64-2026.06.06-232448.tar.gz"
      sha256 "5c7bf30099378745d8fd3b59ea02cccf78ab85c157c01a38f8ae556927dabe7c"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.06-232448/wendy-cli-linux-amd64-2026.06.06-232448.tar.gz"
      sha256 "2fa6aec65ea0ff4632f1c6bb082a870368a62a2dd40168a06588923caacd074d"
    end
  end

  conflicts_with "wendy-nightly", because: "both install a `wendy` binary"

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
    # TODO: It would be better to actually build something, instead of just checking the help text.
    system bin/"wendy", "--help"
    assert_match "wendy [command]", shell_output("#{bin}/wendy --help")
  end
end
