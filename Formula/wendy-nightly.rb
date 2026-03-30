class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.03.30-134132"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "fd0b3a5182240d0e5d9fecdf920c4d7aea89afbfb07b75bff60cf3ad8372d33b"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.30-134132/wendy-cli-darwin-arm64-2026.03.30-134132.tar.gz"
    sha256 "5bbaf0bdaaf77f160d8322dc1f902220462d31e3b9981eff16bf475ebea3471f"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.30-134132/wendy-cli-linux-arm64-2026.03.30-134132.tar.gz"
      sha256 "55334fad0ab956a2a35f4951e5d51dad4548d2fff95845235a42807e6a7584fa"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.30-134132/wendy-cli-linux-amd64-2026.03.30-134132.tar.gz"
      sha256 "01018d2fc90b1a3696612b41b105dc074799bc2f6c2a1ca21d1aab148bed41de"
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
