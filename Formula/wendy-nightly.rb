class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.05.26-195618"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "84895523642e80a535dc8bea1f956b85fd862c5a776ea710fd740bcd87ed9aba"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.05.26-195618/wendy-cli-darwin-arm64-2026.05.26-195618.tar.gz"
    sha256 "da2a9dd099c8dbb06040e10da479127a62ad942540f0f3f77382985c91c88383"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.05.26-195618/wendy-cli-linux-arm64-2026.05.26-195618.tar.gz"
      sha256 "cd9a465e737a56b77f736973b5ac55b28468c765bd8896efe95a5f05ad2b9a2d"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.05.26-195618/wendy-cli-linux-amd64-2026.05.26-195618.tar.gz"
      sha256 "63d9499016820d4a5ba91f6fb0213fcf88d46487425ff339b7942b842978bc64"
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
