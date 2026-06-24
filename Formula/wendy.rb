class Wendy < Formula
  desc "CLI for building and running WendyOS applications"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-2026.06.24-144703"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "d6c3b2ad3e4c1471d81cc5182438dd8accadea2014e2504779acd59b7cec96e6"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.24-144703/wendy-cli-darwin-arm64-2026.06.24-144703.tar.gz"
    sha256 "563d52bf7f28eef53981c9a8225d9200f405f80a90daa07093d6a1e9eba8aaec"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.24-144703/wendy-cli-linux-arm64-2026.06.24-144703.tar.gz"
      sha256 "4b0fc6744e6185a5db465c53e469ef9e2b6350810dc2ca16aa2078f84155e3a6"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.24-144703/wendy-cli-linux-amd64-2026.06.24-144703.tar.gz"
      sha256 "b6257abefd8b6c35f2e574ee13f28d35b56efd9d18a1ec8291b09386bbe5cdd3"
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
