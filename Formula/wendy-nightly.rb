class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.06.08-093832"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "d3adfc427729e9202d9f5eaabaaac1e7d3e7b37d36d6d89125435182fa65d411"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.08-093832/wendy-cli-darwin-arm64-2026.06.08-093832.tar.gz"
    sha256 "705c3a3eb39544d8eac82991b7b26ebed36a0bcbd1cfe3334bb13d57ae54e738"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.08-093832/wendy-cli-linux-arm64-2026.06.08-093832.tar.gz"
      sha256 "005baeac1a00c67da3cc015cf0ffcfdffc0387e251a40beda1c33acc04347f09"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.08-093832/wendy-cli-linux-amd64-2026.06.08-093832.tar.gz"
      sha256 "506659b4a88d3ff433a3997922655120c6f56721277820c2a6edc4e60b88041d"
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
