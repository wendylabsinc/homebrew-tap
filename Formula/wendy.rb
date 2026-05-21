class Wendy < Formula
  desc "CLI for building and running WendyOS applications"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-2026.05.20-174037"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "664ba443e2b02d7757c383afba5d5c5bd2a91c4e05810b5dc793c69d47b16c29"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.05.20-174037/wendy-cli-darwin-arm64-2026.05.20-174037.tar.gz"
    sha256 "852e98bc84eca48470eeeb77537e52bf9f9d2560d2311c98011e3f0d778d080d"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.05.20-174037/wendy-cli-linux-arm64-2026.05.20-174037.tar.gz"
      sha256 "16b580cd45beeea78c240b42e7c24ac7e14475e34b4c9c15d0eaa84044d1ca6e"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.05.20-174037/wendy-cli-linux-amd64-2026.05.20-174037.tar.gz"
      sha256 "e9efa3af47b96d7e5c8a6bb34b061c14c54f8e0bf79f2b9a791c07cbbf65331b"
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
