class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.06.22-123648"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "a3c5ad148a08e9fd469ee87152e7cbd2d12997906b718b197924a020ebbbde23"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.22-123648/wendy-cli-darwin-arm64-2026.06.22-123648.tar.gz"
    sha256 "b0eeb94cd622f457a63cba4131077c776c00bfd5574b95106bdd82a6461ebf84"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.22-123648/wendy-cli-linux-arm64-2026.06.22-123648.tar.gz"
      sha256 "01f92561b8ab09d0465c207884b17b3b0fcf7c4ad324c58e3c81232e12861078"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.22-123648/wendy-cli-linux-amd64-2026.06.22-123648.tar.gz"
      sha256 "20171b80177af37c392387bcd331e55d7f04d02d9761a35dea966e97510ccc0d"
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
