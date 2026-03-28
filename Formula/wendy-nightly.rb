class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.03.28-014447"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "e563bd4c580651d34e91ac15a85b76209291dbdbc0a74eecaafd3fccb1cc12c2"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.28-014447/wendy-cli-darwin-arm64-2026.03.28-014447.tar.gz"
    sha256 "c5c938d5a9d9bbce51241c263477538d64148ad26a04c0e0e8218c5fa02dd51e"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.28-014447/wendy-cli-linux-arm64-2026.03.28-014447.tar.gz"
      sha256 "067fef29f7b3360daa5f8a7b99714a632c69186b70ec550057a1d2c4d18c58e9"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.28-014447/wendy-cli-linux-amd64-2026.03.28-014447.tar.gz"
      sha256 "e490ca0a686e0d8e1c82666c15c432271cb3c2cc56b61bce7d02a53ba11c24f6"
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
