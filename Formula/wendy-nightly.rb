class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.06.08-183544"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "a95ceeb8b0fc2c42f51ddc4a7802b90bdac76a7a415d3c4391243f359cddb262"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.08-183544/wendy-cli-darwin-arm64-2026.06.08-183544.tar.gz"
    sha256 "cdd104b985daa4ceeb5559ebd1426a9c79b3f30f549b03150cc2de0ebebfae15"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.08-183544/wendy-cli-linux-arm64-2026.06.08-183544.tar.gz"
      sha256 "3b888197cc8e3b292035443e05f40a1f906021180e7b1d5c02e840173a4ec8b9"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.08-183544/wendy-cli-linux-amd64-2026.06.08-183544.tar.gz"
      sha256 "87a7d16d401aedea96b9880c18b71e26a69c840d3d57d4e8d536351c13b4d0a8"
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
