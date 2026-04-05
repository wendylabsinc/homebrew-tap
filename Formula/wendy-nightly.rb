class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.04.05-104230"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "e28e7fffd1262bcc8e83d46056bee3f146df57387d8365c247f871588aaea10a"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.05-104230/wendy-cli-darwin-arm64-2026.04.05-104230.tar.gz"
    sha256 "d82a1d03f5d270eb27250eddaaf0d10c43b8e43e65529a1d34d17bfcd0c01d3c"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.05-104230/wendy-cli-linux-arm64-2026.04.05-104230.tar.gz"
      sha256 "2c0ee1c4d3fd32642241d2f4053d5075febc642007a8abb4256e8de39e8c0cc4"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.05-104230/wendy-cli-linux-amd64-2026.04.05-104230.tar.gz"
      sha256 "f74f3fcffedf22aef6470405dd66016b0b6c2a87ef048ec6bc4d7ff8e0f8e0ea"
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
