class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.05.11-150334"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "45f69713d2a953f3c66abaa2959b9897226850f7456aabdce1213babaa648b4d"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.05.11-150334/wendy-cli-darwin-arm64-2026.05.11-150334.tar.gz"
    sha256 "3f37f733ce71177d4790715770436e94b0d3e105819cd84d8501d68bd15cf899"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.05.11-150334/wendy-cli-linux-arm64-2026.05.11-150334.tar.gz"
      sha256 "93e83cef164957b880803c718884e458d64d2f2e32c7da1f2bc75f86b98982d0"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.05.11-150334/wendy-cli-linux-amd64-2026.05.11-150334.tar.gz"
      sha256 "a947d9df9818ec3f440b0115f8c87345d70fbeb047857274ab93ae44a8e74aa9"
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
