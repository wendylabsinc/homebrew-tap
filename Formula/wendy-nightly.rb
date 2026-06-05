class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.06.05-103225"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "03e646e2a8f293b814dafa35cee4ec412e26642de492e812e9905e8f80ea7a2e"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.05-103225/wendy-cli-darwin-arm64-2026.06.05-103225.tar.gz"
    sha256 "8862423fb45c5e5522dc6e9503d8a05716831a6572c1c423d203864a2006a89d"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.05-103225/wendy-cli-linux-arm64-2026.06.05-103225.tar.gz"
      sha256 "58a9132e22112377b1e9739f1a1842a9aa02c8a029e734574dcf3041cd4c8ff0"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.05-103225/wendy-cli-linux-amd64-2026.06.05-103225.tar.gz"
      sha256 "a6e4be8d9aa7e3c7d5b8dc5058edf7ce99fcca115ffe3afc87c524b7e11f3fa7"
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
