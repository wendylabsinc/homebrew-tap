class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.05.04-130056"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "38199ba7b1036a702b6665979411ce2d8da868300a67d387051e4aa4bcc6fc5a"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.05.04-130056/wendy-cli-darwin-arm64-2026.05.04-130056.tar.gz"
    sha256 "0330dc35553b76074abfcb88ffe7497378fb01aa2bbf3d3dc52a60b964f5b49d"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.05.04-130056/wendy-cli-linux-arm64-2026.05.04-130056.tar.gz"
      sha256 "a56cc7f1d85e934a0bf1ce9bbe7a5b31478acc5af41a97b755270be838254431"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.05.04-130056/wendy-cli-linux-amd64-2026.05.04-130056.tar.gz"
      sha256 "8376d66380e311b97fb3f072ff56a90bc9d4b7b32c04046e89d0dbc7e32cf90d"
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
