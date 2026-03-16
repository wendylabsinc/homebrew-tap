class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.03.16-165003"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "431d410f9ddb437efd694fccabe40c1145f185e2aa2a20126de34217c7c4bff6"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.16-165003/wendy-cli-darwin-arm64-2026.03.16-165003.tar.gz"
    sha256 "d13d07aac4001d956a9f61557e479c01eb5be8ca717bd0e51cd0ef63748d6cbd"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.16-165003/wendy-cli-linux-arm64-2026.03.16-165003.tar.gz"
      sha256 "316b48c4d7998304a005742eed526108758572ff79cdf59e85df7cc8ebfd87fb"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.16-165003/wendy-cli-linux-amd64-2026.03.16-165003.tar.gz"
      sha256 "09db0b9f861a612a2f18513d621a365fcad176a900669bc4eb0d150017c12a7c"
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
