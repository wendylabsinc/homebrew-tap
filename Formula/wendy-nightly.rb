class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.04.17-211457"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "7f0a29823d6e23bc1a02aeeda1aa94137575eaf3769d098a9cd3f242c6a098bb"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.17-211457/wendy-cli-darwin-arm64-2026.04.17-211457.tar.gz"
    sha256 "43cb4105d871d783231615fd93999c323c5763c706c0bb3427c22756244534af"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.17-211457/wendy-cli-linux-arm64-2026.04.17-211457.tar.gz"
      sha256 "af707cb15411a73d7df354ecd624ad7d0cfc62feb18d350d146df73cc4e38379"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.17-211457/wendy-cli-linux-amd64-2026.04.17-211457.tar.gz"
      sha256 "bafd1421b32d803c53c26ba95a82fb2ce93a36e7c9b60fe1fbad3d1f66fcab7e"
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
    system bin/"wendy", "--help"
    assert_match "OVERVIEW: Wendy CLI", shell_output("#{bin}/wendy --help")
  end
end
