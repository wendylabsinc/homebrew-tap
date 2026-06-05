class Wendy < Formula
  desc "CLI for building and running WendyOS applications"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-2026.06.05-173402"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "5d7a1fb7e7c7426d9ad100e983908773a6bf5193bd302148eeb4ca74ca9c42eb"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.05-173402/wendy-cli-darwin-arm64-2026.06.05-173402.tar.gz"
    sha256 "ea6b0cda94e4be204b13047eb1c63ef8f570280546fbabe419705c7a9bc6c462"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.05-173402/wendy-cli-linux-arm64-2026.06.05-173402.tar.gz"
      sha256 "a4713859d687330d94d5a87711bea7c269525b40666fd76e6578cf3aff5a76ac"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.05-173402/wendy-cli-linux-amd64-2026.06.05-173402.tar.gz"
      sha256 "4a580ac893e3550b05a06113cf49be45b7df6b9225ce9d8c45f1f5659dc38b34"
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
