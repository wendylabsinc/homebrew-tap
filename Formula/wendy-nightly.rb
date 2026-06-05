class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.06.05-170530"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "dcc2641d6340bebd643fd09c70ed4ea2068eabb82c0eb52b8542e278e171199e"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.05-170530/wendy-cli-darwin-arm64-2026.06.05-170530.tar.gz"
    sha256 "7960d967a4bf83a66ce1d5e5a43ec5900b7c33d3748dc8ea6cb5a5b9302e710a"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.05-170530/wendy-cli-linux-arm64-2026.06.05-170530.tar.gz"
      sha256 "d4df3034ddd45182c6747e2547a8ac2e618f9c1f6fe3ac3252e9724e08ba953e"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.05-170530/wendy-cli-linux-amd64-2026.06.05-170530.tar.gz"
      sha256 "c99d7b56210057dc613f1ccb13be46c3ac6c373f7e7afc11b30bf2133549d3c3"
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
