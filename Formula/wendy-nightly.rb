class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.03.12-170317"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "23162d2d365247636409e658452ce59407afecb6fd2dd4cbc9b6de99eff268bc"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.12-170317/wendy-cli-darwin-arm64-2026.03.12-170317.tar.gz"
    sha256 "1b71250c2c2b08193b721e891b79d469599f7452b02cb20c5b647d992f72e8a5"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.12-170317/wendy-cli-linux-arm64-2026.03.12-170317.tar.gz"
      sha256 "89d5a175da29065bf4e97e93375f09f2f47bed2962405f9ececfe994b33f1f23"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.12-170317/wendy-cli-linux-amd64-2026.03.12-170317.tar.gz"
      sha256 "796056939081361910abcb6e07ef1efb024f8906dfe7b6292bfdefe23df81ade"
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
