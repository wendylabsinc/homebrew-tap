class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.04.05-103613"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "e28e7fffd1262bcc8e83d46056bee3f146df57387d8365c247f871588aaea10a"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.05-103613/wendy-cli-darwin-arm64-2026.04.05-103613.tar.gz"
    sha256 "4dbe3ac45b8c32bde012afa1466dcdc1fdf0354a808c2937ed0e8c3e3e65edd4"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.05-103613/wendy-cli-linux-arm64-2026.04.05-103613.tar.gz"
      sha256 "667c33f24564536b658cd7c02a7d64115afb37c0d8c277e115522b9196485bd2"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.05-103613/wendy-cli-linux-amd64-2026.04.05-103613.tar.gz"
      sha256 "bcf719d6d71ab48bebf0a2b0fe82b58f6334f6437169db9d2a6df5b9a53d8b97"
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
