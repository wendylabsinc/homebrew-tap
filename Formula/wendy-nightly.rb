class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.06.28-162828"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "07226ca30e689f116005b9f560f3c53e254e2d3d38891a287ecd76b951085afe"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.28-162828/wendy-cli-darwin-arm64-2026.06.28-162828.tar.gz"
    sha256 "f0c8d783be85bc6cbc3c0368508fd7b76211969e7c5a7919b7a81896994f4d75"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.28-162828/wendy-cli-linux-arm64-2026.06.28-162828.tar.gz"
      sha256 "849d2def273ba63a65ae1b506fd96872e080986a9f8bbf30fa99cbc671608880"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.28-162828/wendy-cli-linux-amd64-2026.06.28-162828.tar.gz"
      sha256 "77a83d70fecba35d63e1545903478796f16805691886b304d1e68b039692b14d"
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
