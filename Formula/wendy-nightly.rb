class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.06.03-175757"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "0ee97e02e630023420bb1447e71cd17cca5a9ed6d984035b10b8a5954a56fb4a"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.03-175757/wendy-cli-darwin-arm64-2026.06.03-175757.tar.gz"
    sha256 "452e7fc65f24d89eabe1d66d837babadf6dcaf7aa996a174efa9092f0f49d37f"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.03-175757/wendy-cli-linux-arm64-2026.06.03-175757.tar.gz"
      sha256 "1d7b78c2d96c4bcbbaf64048bfeb58731cb44d13eb399b297a6b940a1e5045e9"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.03-175757/wendy-cli-linux-amd64-2026.06.03-175757.tar.gz"
      sha256 "b4f7cf1fdbf92331ddd944c0b34bc68d53ffaafab6f956ad451f9bd5409fbb6e"
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
