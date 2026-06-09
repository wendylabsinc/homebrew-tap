class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.06.09-175520"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "b605d3d1bb3c789874e4dd2ece849d5fd83cedcafbef2d1b6875b736d655e31b"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.09-175520/wendy-cli-darwin-arm64-2026.06.09-175520.tar.gz"
    sha256 "a4471cdab0aaf6d0ad25ba0226378b52e8dcd558d2ad2ad12d51986ae8359383"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.09-175520/wendy-cli-linux-arm64-2026.06.09-175520.tar.gz"
      sha256 "64bfdfda0e51129c70a314a7ee8469b1ab29372413db1b47d21dbd4b2f2a8bd1"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.09-175520/wendy-cli-linux-amd64-2026.06.09-175520.tar.gz"
      sha256 "2cd6e299c1a0f25ba8b89fc5d33de7085a5985569cf32c06765ea95bbc90f0fb"
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
