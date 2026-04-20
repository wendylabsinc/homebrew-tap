class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.04.20-212302"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "afb5f6ddb7cb5de940fdd018c25f3fa1d2bf184ef2845bef0934d0dfd80f6fa2"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.20-212302/wendy-cli-darwin-arm64-2026.04.20-212302.tar.gz"
    sha256 "9b5acc56d45e44a5369b76516afccfcbad9be127bffa35f5f75df93ea7988b1d"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.20-212302/wendy-cli-linux-arm64-2026.04.20-212302.tar.gz"
      sha256 "079c43c94259f6f2b74039c037056370490f0fc9c00219ea427558cf292bd54d"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.20-212302/wendy-cli-linux-amd64-2026.04.20-212302.tar.gz"
      sha256 "913808543aedc937ab8aacf6c835d4630e55fc72772171e552dd516d84328f60"
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
