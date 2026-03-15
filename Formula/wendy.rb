class Wendy < Formula
  desc "CLI for building and running WendyOS applications"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-2026.03.15-173615"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "3a57e3b48a5d876575b0b3899f66a344da36ae1a083399eec36edee14e44e60b"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.15-173615/wendy-cli-darwin-arm64-2026.03.15-173615.tar.gz"
    sha256 "6c5956aa01e889a7cafbd3cde88a55c912ee66c242e4f2b133b78c39ff5c9351"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.15-173615/wendy-cli-linux-arm64-2026.03.15-173615.tar.gz"
      sha256 "4ed95bda08b5dc714d355a5510d56abf9b027d547f0207ab874e9939f63a66ba"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.15-173615/wendy-cli-linux-amd64-2026.03.15-173615.tar.gz"
      sha256 "22a65cf1894ed2d4ffbda39d32848e2fde1346faeea5f05fc80cb717f890c8ec"
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

  def caveats
    <<~EOS
      Attention: The Wendy CLI collects anonymous analytics.
      They help us understand which commands are used most, identify common errors, and prioritize improvements.
      Analytics are enabled by default. If you'd like to opt-out, use the following command:
        wendy analytics disable
      Or, set the following environment variable:
        WENDY_ANALYTICS=false
    EOS
  end

  test do
    # TODO: It would be better to actually build something, instead of just checking the help text.
    system bin/"wendy", "--help"
    assert_match "wendy [command]", shell_output("#{bin}/wendy --help")
  end
end
