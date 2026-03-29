class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.03.29-180328"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "0e6610fed215b801243a11a9ad2ff52ef0218beffe3cf7c6df3a3bbec1e9f25d"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.29-180328/wendy-cli-darwin-arm64-2026.03.29-180328.tar.gz"
    sha256 "cc44e789384c6679ce0aa083ebd9161d09752c86a7c1ed2454abb4c885b3040e"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.29-180328/wendy-cli-linux-arm64-2026.03.29-180328.tar.gz"
      sha256 "e43db0f0db87ae4459e0726d2f5b2f72dc66651dcc8c8a0ccc635f91af36509e"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.29-180328/wendy-cli-linux-amd64-2026.03.29-180328.tar.gz"
      sha256 "ab30c79010a7fe5d458a9f231d2c3e5aa398b6363da88fad8867a955137be3d2"
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
