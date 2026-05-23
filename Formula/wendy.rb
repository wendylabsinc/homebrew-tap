class Wendy < Formula
  desc "CLI for building and running WendyOS applications"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-2026.05.23-190411"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "664ba443e2b02d7757c383afba5d5c5bd2a91c4e05810b5dc793c69d47b16c29"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.05.23-190411/wendy-cli-darwin-arm64-2026.05.23-190411.tar.gz"
    sha256 "171806793d811b199f0062680024e598b991b26803893d2b55e4227ccf77644e"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.05.23-190411/wendy-cli-linux-arm64-2026.05.23-190411.tar.gz"
      sha256 "04e24b2ad2a9d39eba4391c81a8007041038769e032b02b45a5ae121ffc84dfb"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.05.23-190411/wendy-cli-linux-amd64-2026.05.23-190411.tar.gz"
      sha256 "9fb79b48a4bb264274daa26f55b858d6972f2545bd91a5736d6e2e64ddc76b68"
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
