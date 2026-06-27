class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.06.27-182952"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "d97ca005b4192c7a398df1d79f4ee0069e3e3949ec55d0ece47edd9db804be80"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.27-182952/wendy-cli-darwin-arm64-2026.06.27-182952.tar.gz"
    sha256 "ce72cfd5dbd00cec229814dae09bf67463391a074eed70ee906e1ff36524a42f"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.27-182952/wendy-cli-linux-arm64-2026.06.27-182952.tar.gz"
      sha256 "76463e0c80142917e42dabcc54e1ebf8bb88b4fb7d16ad4fc141d63232722295"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.27-182952/wendy-cli-linux-amd64-2026.06.27-182952.tar.gz"
      sha256 "4d704fc33013b3d8b13aa4aa1d8e621880982cf6c61ab5765efc2e85c3fbc482"
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
