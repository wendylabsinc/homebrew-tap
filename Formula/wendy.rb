class Wendy < Formula
  desc "CLI for building and running WendyOS applications"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-2026.06.24-080311"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "acba55098613fa9bb3ce6220bf66ad33413d988b290d9b1ac4d1098c5f59ee45"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.24-080311/wendy-cli-darwin-arm64-2026.06.24-080311.tar.gz"
    sha256 "8b2ff8361573d7ca45271df2cfb026d9f8289875bb2781f742f12568f1a00c73"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.24-080311/wendy-cli-linux-arm64-2026.06.24-080311.tar.gz"
      sha256 "c39b52bc3e7ddb9efc38e93b99a812cb9236808f7f5a898f4eb8f9513daa2842"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.24-080311/wendy-cli-linux-amd64-2026.06.24-080311.tar.gz"
      sha256 "5758d3e243313e42e6896cb86eed34c21167a4b1a1347c86faa240fd498e7d07"
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
