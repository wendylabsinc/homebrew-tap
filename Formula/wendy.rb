class Wendy < Formula
  desc "CLI for building and running WendyOS applications"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-2026.06.02-204007"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "78124d85cbbf6894d933b255bf9931a814a2d7f580b2d48dc5ba249d373ffec4"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.02-204007/wendy-cli-darwin-arm64-2026.06.02-204007.tar.gz"
    sha256 "ace550407ab7b00ea7a15a129f2535d411fa96fff7db9ebbbea608f37ff77133"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.02-204007/wendy-cli-linux-arm64-2026.06.02-204007.tar.gz"
      sha256 "a2225995d97a950035784e1f0274cd1b2fe2cf8670097ebfd338c1d51c1f9b35"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.02-204007/wendy-cli-linux-amd64-2026.06.02-204007.tar.gz"
      sha256 "6ab10498e00ec521012800bfa89884da2036d08b1ef037282962bbdb93b67ae1"
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
