class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.06.17-211446"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "c687b2de157f62bb08b021bf8fa8f67aebc409817966681aea4d4915267f79e3"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.17-211446/wendy-cli-darwin-arm64-2026.06.17-211446.tar.gz"
    sha256 "23ed62aee8c04a317dc9d27157aae3d907bbc16fa26a88cfdbf8b311ba7a1440"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.17-211446/wendy-cli-linux-arm64-2026.06.17-211446.tar.gz"
      sha256 "9aefaddc6faf6f75a5790b4ebe6bff11522c8640a9d4b1bec64407ae73154995"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.17-211446/wendy-cli-linux-amd64-2026.06.17-211446.tar.gz"
      sha256 "f6b2a62824bad46935cdf1ac002896ac9468d746d6baa2453cf41854d107d6d1"
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
