class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.06.17-123819"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "9e2fa0781949a34c085a80864d94acc7639e89a2d11f93406c6604cdabb78220"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.17-123819/wendy-cli-darwin-arm64-2026.06.17-123819.tar.gz"
    sha256 "81ae648c19a2164f8825d208ff44688c74c9bc007eb728757dde02311ff4b79a"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.17-123819/wendy-cli-linux-arm64-2026.06.17-123819.tar.gz"
      sha256 "da3cc2dead7ff6b10f501e790f794d75bf17a934c9dfa598ed5d8c62be7d56e7"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.17-123819/wendy-cli-linux-amd64-2026.06.17-123819.tar.gz"
      sha256 "4bcb46e9d42cdce27f57cd6785b712b987d6bf43f6239f39363dfce9c2ec7afa"
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
