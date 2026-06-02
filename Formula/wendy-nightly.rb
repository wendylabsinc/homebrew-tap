class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.06.02-091529"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "3cb25da899b1cf7eec9605652b759bd29345d2351be06e7cbe9de34f8817a4f2"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.02-091529/wendy-cli-darwin-arm64-2026.06.02-091529.tar.gz"
    sha256 "25a344f2c034804f7a930dd5fabef575769bcc4eda0711be782233c9992ee231"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.02-091529/wendy-cli-linux-arm64-2026.06.02-091529.tar.gz"
      sha256 "6d463f18172ce4d1058ae02c03cebc277f41f3a157fe01fcf80a4137bd470dd8"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.02-091529/wendy-cli-linux-amd64-2026.06.02-091529.tar.gz"
      sha256 "083f24856a0ac80050cda606ea68d90fc9434846aa7cda97052812a90d902d4c"
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
