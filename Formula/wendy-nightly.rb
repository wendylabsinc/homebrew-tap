class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.04.14-173233"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "1276e51cec095faaf8f7d118311e248d5e17dd773239df5bfadff4074e301f3b"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.14-173233/wendy-cli-darwin-arm64-2026.04.14-173233.tar.gz"
    sha256 "00c58211f67b19a57225f08ff19c5679380db32867f56b16097c2efdb0bc51ce"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.14-173233/wendy-cli-linux-arm64-2026.04.14-173233.tar.gz"
      sha256 "a307fd0a872136b3d32107cc2714fce056c75a654b3b1ffbc32a4518df186300"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.14-173233/wendy-cli-linux-amd64-2026.04.14-173233.tar.gz"
      sha256 "6f5597a774be872a51df99a454f58b9baa6e62dd41406f7a482628c896e7e9c1"
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
