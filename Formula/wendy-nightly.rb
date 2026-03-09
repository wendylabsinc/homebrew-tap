class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.03.09-103130"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "a48237cb27f2d670eba25bdba00580c67fb60bca9055b329002f890e94ead07c"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.09-103130/wendy-cli-darwin-arm64-2026.03.09-103130.tar.gz"
    sha256 "bf68e011b54f12ab8978e8783abde74cfb07ee6f6f8973d5bde45d1c71b89436"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.09-103130/wendy-cli-linux-arm64-2026.03.09-103130.tar.gz"
      sha256 "68bd94a8cd1d6cba27a141994baf3fb3f03b815beb79d07c4c8b1c00fc162231"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.09-103130/wendy-cli-linux-amd64-2026.03.09-103130.tar.gz"
      sha256 "ddd2703163b5f3e1c8799d647ef25b71808691ac201179ceb77fd04b00f5fdc9"
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
