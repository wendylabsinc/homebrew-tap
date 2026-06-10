class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.06.10-114159"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "660c4930b074196e913947728f9165f6b6e80258b4405a4b8f07464fd778b174"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.10-114159/wendy-cli-darwin-arm64-2026.06.10-114159.tar.gz"
    sha256 "79a9ed2b06bdb077e22f0a9a44d34df84a11149a07419cdc3b3d0bc55c6366d3"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.10-114159/wendy-cli-linux-arm64-2026.06.10-114159.tar.gz"
      sha256 "06d8270cb0cb3d381713b521e1ecbaf90f65dc47095a5a223f851b8f5f4bfb04"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.10-114159/wendy-cli-linux-amd64-2026.06.10-114159.tar.gz"
      sha256 "11b9c3324ec3220af1862d217941690ec48989ded18ed51460e0a99d41213c88"
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
