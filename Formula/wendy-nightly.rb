class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.06.01-114948"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "297363c0952652fe8c4e21cd6b6f428970cb09d90c6a4bd376af9337528bfd63"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.01-114948/wendy-cli-darwin-arm64-2026.06.01-114948.tar.gz"
    sha256 "95c0df3969f14d6e62228d05dea66de5b3d0ca1c8a0b25914986eaed24582736"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.01-114948/wendy-cli-linux-arm64-2026.06.01-114948.tar.gz"
      sha256 "7c5fadaa4e3a15129b21f3dc767ce33c3d28bc73e305c5aae754b3df2fcbeee2"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.01-114948/wendy-cli-linux-amd64-2026.06.01-114948.tar.gz"
      sha256 "690c0dc65d2b87cff71e039dbbb3828634057ce58cedafab15eaadb7adc3c6fa"
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
