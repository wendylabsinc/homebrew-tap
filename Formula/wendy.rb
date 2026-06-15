class Wendy < Formula
  desc "CLI for building and running WendyOS applications"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-2026.06.15-231721"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "eac9750754b031c561808a3f6447ff96b8ec9b3dd302d6151d49d15a29a6489e"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.15-231721/wendy-cli-darwin-arm64-2026.06.15-231721.tar.gz"
    sha256 "b5419df528934854a9dbaa9abc33b002ca89bced294113591666e00a3dfca1f2"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.15-231721/wendy-cli-linux-arm64-2026.06.15-231721.tar.gz"
      sha256 "178e075beef0cff2eaf355bf0200cbfaedfae9e86624e39f307863f595e91f6e"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.15-231721/wendy-cli-linux-amd64-2026.06.15-231721.tar.gz"
      sha256 "423b49c1999c10b9b4401815d30820b25959f9dc5fbddb5654a5870402b72a3f"
    end
  end

  conflicts_with "wendy-nightly", because: "both install a `wendy` binary"

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
    # TODO: It would be better to actually build something, instead of just checking the help text.
    system bin/"wendy", "--help"
    assert_match "wendy [command]", shell_output("#{bin}/wendy --help")
  end
end
