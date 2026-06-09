class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.06.09-141803"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "eb402980d3cf7e4523a45e1c9aaa421fac425959c20459f66232efb15f0afba6"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.09-141803/wendy-cli-darwin-arm64-2026.06.09-141803.tar.gz"
    sha256 "5995b747f426ea06b9c2b4e72533b3b0b47338e18aef7f2ea6ae72d6a800b621"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.09-141803/wendy-cli-linux-arm64-2026.06.09-141803.tar.gz"
      sha256 "560d3a1959119d2c62d037d8b194f20e7e38ab957d168c86bc2241ef15a208ca"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.09-141803/wendy-cli-linux-amd64-2026.06.09-141803.tar.gz"
      sha256 "b93bf384244afe1a96ee207d62d11acc5982a4ac7f6eb4cc1adb977ad64c7dda"
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
