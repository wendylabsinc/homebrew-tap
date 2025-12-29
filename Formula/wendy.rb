class Wendy < Formula
  desc "CLI for building and running WendyOS applications"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-2025.12.26-211420"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "7236a081f3f11d311096e7906274cf4ec7ec0135ad2f953a70b595ea449964b9"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.12.29-100234/wendy-cli-macos-arm64-2025.12.29-100234.tar.gz"
    sha256 "c9ef7b825f535ea2e158a444bc30e1c2848dd8e83a225af832de8f5439130c6e"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.12.29-100234/wendy-cli-linux-static-musl-aarch64-2025.12.29-100234.tar.gz"
      sha256 "dbdeea9ac58064ac756ac676d556427fdc2f838e047c627bf8cddd90ca3278dc"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.12.29-100234/wendy-cli-linux-static-musl-x86_64-2025.12.29-100234.tar.gz"
      sha256 "3031b098a3609cefe8deea162977154fb9bd7d76f2f81cb6534e07e25f0b3c32"
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
