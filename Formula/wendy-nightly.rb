class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.03.21-102451"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "fec8d5ba8766f09fdcecd8ee7607625f102ea7dfcfb30c199d3b863deae96f6a"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.21-102451/wendy-cli-darwin-arm64-2026.03.21-102451.tar.gz"
    sha256 "f491976c217d0c0c09d7747312ecb48ee2ede737daac0a1d31529b593cff6931"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.21-102451/wendy-cli-linux-arm64-2026.03.21-102451.tar.gz"
      sha256 "e2c1bf30cd203605e409218e49f26555c6251b3a021f3b01d505dd4f48240bb4"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.21-102451/wendy-cli-linux-amd64-2026.03.21-102451.tar.gz"
      sha256 "9b17dab84d05b31de6c2018d27df25f2a56b47064b9159fb82a551c0b7728494"
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
