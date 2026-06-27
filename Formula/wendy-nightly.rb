class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.06.27-190538"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "1471d179d9ab1aacca403afbed6b6f39371aed0b7777b6480e76214f0b7f7e64"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.27-190538/wendy-cli-darwin-arm64-2026.06.27-190538.tar.gz"
    sha256 "c28d9082da0a04ac33b3919227e9333ddc45c9faf26d5f58fd6217e8cbf5eb26"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.27-190538/wendy-cli-linux-arm64-2026.06.27-190538.tar.gz"
      sha256 "609c6740e8f2e3ee22836069ee957570d15e072a7e81fd3eaf734854010c7c6f"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.27-190538/wendy-cli-linux-amd64-2026.06.27-190538.tar.gz"
      sha256 "069799afc6c48c2bf1cae253ad57e95b796a8eaff7038b85d6000edbba8ffe40"
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
