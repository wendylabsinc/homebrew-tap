class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.06.27-150914"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "acab6fecc584830793157a172887efa4b66836f6b85a8c688df69dba5f8a702d"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.27-150914/wendy-cli-darwin-arm64-2026.06.27-150914.tar.gz"
    sha256 "2dc055a9722b7efe2dec35c34b13b3969dcad6947c363be198f466cddbf0d92f"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.27-150914/wendy-cli-linux-arm64-2026.06.27-150914.tar.gz"
      sha256 "6fc27dfbaed36bb2fa9a1be9dae58b66b38e3dea153f3e1dc5148d7c8af771b5"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.27-150914/wendy-cli-linux-amd64-2026.06.27-150914.tar.gz"
      sha256 "31ab43fbbef565f68b0f61054caac4b695aa7a1aa957b6f77116e90bae9fdaf1"
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
