class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.06.09-154348"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "580df9a5a19094995afb2bc8bb033d589e1f3b9710318994ede226f83bdee5d7"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.09-154348/wendy-cli-darwin-arm64-2026.06.09-154348.tar.gz"
    sha256 "21431d7d80d8e645d71665082a83392cbe3a1d70bafd567afdbfa942bc3e5b87"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.09-154348/wendy-cli-linux-arm64-2026.06.09-154348.tar.gz"
      sha256 "2bd43a38a3a9e8bec49d3e48beee200c3f5ee84d9f33964ec3b21cbec6b11720"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.09-154348/wendy-cli-linux-amd64-2026.06.09-154348.tar.gz"
      sha256 "f3b84da84d77d06fc8f8d5f39099e4a129f2bf5e9f234e3d6f6ac4e185b1852a"
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
