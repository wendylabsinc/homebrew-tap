class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.06.18-175615"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "a006fd07375772927114a07eacdc0317fdbfbe8f23bc881b83e92c02d3e567b3"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.18-175615/wendy-cli-darwin-arm64-2026.06.18-175615.tar.gz"
    sha256 "33a72d60219f59e4ebef7109aada31f82747df7b07241d58aeca44a35c8db3bd"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.18-175615/wendy-cli-linux-arm64-2026.06.18-175615.tar.gz"
      sha256 "fd508f54f3cd8778c0f4e6d08d75ed736756f4e2cc3f3c563b9310ec9ae24a61"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.18-175615/wendy-cli-linux-amd64-2026.06.18-175615.tar.gz"
      sha256 "dd9781b4157bc96594442d2dd2a7a7d058e12a516f7c18fb7fd09a7046e97609"
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
