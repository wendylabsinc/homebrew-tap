class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.05.04-162049"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "45f69713d2a953f3c66abaa2959b9897226850f7456aabdce1213babaa648b4d"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.05.04-162049/wendy-cli-darwin-arm64-2026.05.04-162049.tar.gz"
    sha256 "0be28ec35e5f2773355a25ff339d400838aa5d41935c1c0d14de1438b923e25f"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.05.04-162049/wendy-cli-linux-arm64-2026.05.04-162049.tar.gz"
      sha256 "12f05bab03007cb58971d40f6b7e264cbd80fc90a2f948b8c00e92e236bb53e4"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.05.04-162049/wendy-cli-linux-amd64-2026.05.04-162049.tar.gz"
      sha256 "a2b01920a8d99b6fdda9d25106628bf014945ac87fa88182ac15d9b6d9be737d"
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
  end

  def caveats
    <<~EOS
      To install shell completions, run:
        wendy completion install

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
