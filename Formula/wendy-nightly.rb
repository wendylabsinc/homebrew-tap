class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.06.04-083856"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "01518813b7fcae36ee3400ee37d8637dc3ded6818e1651afdbcc232c46bcc51f"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.04-083856/wendy-cli-darwin-arm64-2026.06.04-083856.tar.gz"
    sha256 "d4981d04d25a35f3460367a00917219a24be4bd2b2086b5fb2981352c007dc9b"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.04-083856/wendy-cli-linux-arm64-2026.06.04-083856.tar.gz"
      sha256 "fc71843208f4588a0c94b7b5e0a2531280bb0f0c1e48a85d7fb8a5749cec0563"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.04-083856/wendy-cli-linux-amd64-2026.06.04-083856.tar.gz"
      sha256 "7e27e2142119da240aa3b4e7ec20c459f0455f64dbc216b4fb2e46b84b6735d7"
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
