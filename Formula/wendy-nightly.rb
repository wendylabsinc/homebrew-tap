class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.06.28-164902"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "ad377c0b49b8a7ac26ccaaf0fc3e550b340d19d4676eb8cbbca24fdde210fdb6"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.28-164902/wendy-cli-darwin-arm64-2026.06.28-164902.tar.gz"
    sha256 "fcbda059b009418c2068f445a9e629ddf58dc9ce870d5f7c39080c6faa23dd0b"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.28-164902/wendy-cli-linux-arm64-2026.06.28-164902.tar.gz"
      sha256 "e0ca92ff9a4250f258bde61d102c2ca673f889927548f8055d90bf2927d2abda"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.28-164902/wendy-cli-linux-amd64-2026.06.28-164902.tar.gz"
      sha256 "7ce35c916af99887f2332204aeb2191b67bccfc67508cb5cf24fbc2483c18570"
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
