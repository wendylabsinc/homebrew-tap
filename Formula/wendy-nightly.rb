class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.06.18-203258"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "69f212a736918c60a7ee3608f239058a4b3fcdb89613f1696c3e90b8e6e7e581"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.18-203258/wendy-cli-darwin-arm64-2026.06.18-203258.tar.gz"
    sha256 "b857263af3a6a7a363875a08b20683937a8be6b3c385ae65647d2727ed48d1af"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.18-203258/wendy-cli-linux-arm64-2026.06.18-203258.tar.gz"
      sha256 "1c08375e0e8c9580988d2a8e236a9b55066895d6e5ba204bd02cfbd5e4851cc4"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.18-203258/wendy-cli-linux-amd64-2026.06.18-203258.tar.gz"
      sha256 "930f98f02ab1bff9ead126c9ebc65dce2598525b7104a7342f9af54ee40d01b6"
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
