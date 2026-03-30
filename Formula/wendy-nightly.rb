class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.03.30-122001"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "3168e100af8add709fe4d4370c9c0327e6bea406f0cfac170140fc89fb860a10"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.30-122001/wendy-cli-darwin-arm64-2026.03.30-122001.tar.gz"
    sha256 "2db6b3a0e4a0220cc1ab1f1fb31ddf5c731eb633c007b5d1774eb6a31c05a634"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.30-122001/wendy-cli-linux-arm64-2026.03.30-122001.tar.gz"
      sha256 "6fbee61cd054687707a8d6562b49e1fc5c27d574f583ed361f13d2840fe5f360"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.30-122001/wendy-cli-linux-amd64-2026.03.30-122001.tar.gz"
      sha256 "b96eeca815d6cbcfd0dd4d01557b42707a382cd7d8aebcb83525aaf955df4ecd"
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
