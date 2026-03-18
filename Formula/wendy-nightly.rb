class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.03.18-201536"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "767a1aabecee52fab8ade5e7f11dac0cd3407c95dfdd669de2d49d16aa8476e5"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.18-201536/wendy-cli-darwin-arm64-2026.03.18-201536.tar.gz"
    sha256 "f3acacf315e34eb5e48e7f6862973a4afbc4b76525d6fd2602dc89fd3a280592"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.18-201536/wendy-cli-linux-arm64-2026.03.18-201536.tar.gz"
      sha256 "63721251dc13b4a0c6a31c32081a1b0869d8112bf9309966e40b1143c3c64410"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.18-201536/wendy-cli-linux-amd64-2026.03.18-201536.tar.gz"
      sha256 "64123d53636abef3a08c782df348fd7ef511fe7bb9b01f68082d1b9a4d97594a"
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
