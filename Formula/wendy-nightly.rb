class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.06.06-192058"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "769e833fcff410cce4161ca3462e3718601e6e26fe177ac5b68f3a8e1dd4f359"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.06-192058/wendy-cli-darwin-arm64-2026.06.06-192058.tar.gz"
    sha256 "190e2c32fc40d17ac4f0d85a0de2912d552dbd0bad6fbcbe268d57ee731ff75d"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.06-192058/wendy-cli-linux-arm64-2026.06.06-192058.tar.gz"
      sha256 "e12225a36cf09811acc81d8eab913b722acec5e1c00cd1d3f4acb6a6563ea787"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.06-192058/wendy-cli-linux-amd64-2026.06.06-192058.tar.gz"
      sha256 "5e48614e4c50c5942ebf49c1b27535ca765163eb105f4faf4f5dc48edf69fbea"
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
