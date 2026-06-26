class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.06.26-110526"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "94c548ec5a7830358ffe7034540ff8d1d2ad2d40788e6f0f9f743e0a66570a09"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.26-110526/wendy-cli-darwin-arm64-2026.06.26-110526.tar.gz"
    sha256 "eec38c113ce7b848f4e41ad6825979bbb70d8f634a1d3a89160e459c02127602"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.26-110526/wendy-cli-linux-arm64-2026.06.26-110526.tar.gz"
      sha256 "e835fd86c1e712d6fd8164f96e8698d7a98691fe3bea9a423a3882d4736537f6"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.26-110526/wendy-cli-linux-amd64-2026.06.26-110526.tar.gz"
      sha256 "df8132d56e12742578ed9ad00229c42888eaa0e8f4b4a1c78dcd2e202e1f7cd9"
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
