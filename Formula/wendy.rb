class Wendy < Formula
  desc "CLI for building and running WendyOS applications"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-2025.12.30-104150"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "ccf133cd4d5276f01de69554ac40106006e769f81c16f99924ee9fad6f630e67"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.12.30-140713/wendy-cli-macos-arm64-2025.12.30-140713.tar.gz"
    sha256 "3f3939aa48616669e17a27f38f23e7e7730fa44465f64fa0ce1b8635b2beaf02"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.12.30-140713/wendy-cli-linux-static-musl-aarch64-2025.12.30-140713.tar.gz"
      sha256 "accd711995a4cecd1216dcf1d5699b59162bf897c9e43546e44f574e361e9e11"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.12.30-140713/wendy-cli-linux-static-musl-x86_64-2025.12.30-140713.tar.gz"
      sha256 "1d16b95e5f822344bf0f2e8ca53c6574ec1e8ee76cd8d439888ca9102cebdd02"
    end
  end

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
    assert_match "OVERVIEW: Wendy CLI", shell_output("#{bin}/wendy --help")
  end
end
