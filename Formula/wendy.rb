class Wendy < Formula
  desc "CLI for building and running WendyOS applications"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-2026.06.25-153233"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "d6c3b2ad3e4c1471d81cc5182438dd8accadea2014e2504779acd59b7cec96e6"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.25-153233/wendy-cli-darwin-arm64-2026.06.25-153233.tar.gz"
    sha256 "398c5cc0dce9393f1587686074522a6162f834e8b5fcb10ffc9dc0ca8210b564"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.25-153233/wendy-cli-linux-arm64-2026.06.25-153233.tar.gz"
      sha256 "462b8f6c8ae7f984e62d035cea678d4a8be0914b37d86b72d46bf791bf2c0620"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.25-153233/wendy-cli-linux-amd64-2026.06.25-153233.tar.gz"
      sha256 "c6c68efdc8059c0a1d7045d7e4d430cddb5d3b59c6eb46220fb926da429b95e3"
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
