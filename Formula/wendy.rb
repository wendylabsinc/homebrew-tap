class Wendy < Formula
  desc "CLI for building and running WendyOS applications"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-2026.04.20-212532"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "b531cbddd374e3779e040388a3418b42c2b1184aa0790fad6ada965ce9f736cb"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.20-212532/wendy-cli-darwin-arm64-2026.04.20-212532.tar.gz"
    sha256 "72ea92282eae9552db7b2c71b32d3ec33a50694608cb69400dbcf7156a4114ed"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.20-212532/wendy-cli-linux-arm64-2026.04.20-212532.tar.gz"
      sha256 "e2c6515f22f047ee609799f815cf3732114323a7fb4ea4e0a65e2493d2c0103d"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.20-212532/wendy-cli-linux-amd64-2026.04.20-212532.tar.gz"
      sha256 "9b4a8e3073c323df52a1de87feefe461fbdf01ffe2fade32754328c6b9ba8d60"
    end
  end

  conflicts_with "wendy-nightly", because: "both install a `wendy` binary"

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
    # TODO: It would be better to actually build something, instead of just checking the help text.
    system bin/"wendy", "--help"
    assert_match "wendy [command]", shell_output("#{bin}/wendy --help")
  end
end
