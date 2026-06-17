class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.06.17-102749"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "8c0909fcdc2d072ed57976f38f62dafc7423ae155b3132a76bcc8d4c34975fc8"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.17-102749/wendy-cli-darwin-arm64-2026.06.17-102749.tar.gz"
    sha256 "6a0157390bd662839f65d4ab4d701301ea7745d05b177d6218791cd673c2cd32"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.17-102749/wendy-cli-linux-arm64-2026.06.17-102749.tar.gz"
      sha256 "1470acac6177a1477eaf706cf0447ec874281878b195a93e44b2e37db8d288fe"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.17-102749/wendy-cli-linux-amd64-2026.06.17-102749.tar.gz"
      sha256 "6e5a6874f7de0ca8c990b752efd4ba01402a45e7d6b03cb6514884ffa3aaec3f"
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
