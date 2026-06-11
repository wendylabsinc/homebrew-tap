class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.06.11-135137"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "3cdf037dbf6c6923264fadc7dd2e3aa434e67ca0a35f3c7eadf6ff871b16285e"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.11-135137/wendy-cli-darwin-arm64-2026.06.11-135137.tar.gz"
    sha256 "7f211a7a5b6065a5b6f95bbe40a3520a547be81202c889260ba343bd840c64b7"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.11-135137/wendy-cli-linux-arm64-2026.06.11-135137.tar.gz"
      sha256 "21242ebdae2521befe1cd723c5c8c5a8a46fb85627f68606da62171004890690"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.11-135137/wendy-cli-linux-amd64-2026.06.11-135137.tar.gz"
      sha256 "6bf56c0b02074b5e2d85f2e881baa8e2a02113b55514a5cb17e6023bc59d8939"
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
