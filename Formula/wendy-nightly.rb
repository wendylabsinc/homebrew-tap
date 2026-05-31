class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.05.31-085126"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "e2b023fceec9b1e4f478ce9fb56fe41791b5d43cf214718ffabac610f208ea9e"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.05.31-085126/wendy-cli-darwin-arm64-2026.05.31-085126.tar.gz"
    sha256 "21438e675582a2dd66f8143bec15f59eac8109589fb4d2ba4faf09bda6a8b9d6"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.05.31-085126/wendy-cli-linux-arm64-2026.05.31-085126.tar.gz"
      sha256 "dd6588140c3bb1c0987ac90c0a49ac97595288176168e28cc07272a80d149289"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.05.31-085126/wendy-cli-linux-amd64-2026.05.31-085126.tar.gz"
      sha256 "b9917af16edcc2377f28cfc94b6104f55fd202ecf6a9dac15878844139455373"
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
