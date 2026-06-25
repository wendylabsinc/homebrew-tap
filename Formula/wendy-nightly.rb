class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.06.25-125311"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "955d020950695162af2e9ba9d97786d5f60aa5eb636c1ab655858a816081dad4"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.25-125311/wendy-cli-darwin-arm64-2026.06.25-125311.tar.gz"
    sha256 "2dad4a8241525e3a215c3fa3830807dd9d153d4c87c285b886db3bf874bec2d0"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.25-125311/wendy-cli-linux-arm64-2026.06.25-125311.tar.gz"
      sha256 "370073773c69744fb8cea6f5657529d6cea3ebd76e0ccd8a05bb09e2fa51f807"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.25-125311/wendy-cli-linux-amd64-2026.06.25-125311.tar.gz"
      sha256 "41efb20eb5b551357f551ed16a107b43ebc3e5215b38cf101c0703bf5b9fa6f5"
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
