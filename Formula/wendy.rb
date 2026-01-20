class Wendy < Formula
  desc "CLI for building and running WendyOS applications"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-2026.01.13-230914"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "636ae749daa56258672801b5c5993743c7a09a3f3dde5f937ac8c340fb09f899"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.01.20-192943/wendy-cli-macos-arm64-2026.01.20-192943.tar.gz"
    sha256 "8ca5766a8307fa1b2c55bb77b8edd8aa7a862aa2ac409d463973df70c3c3dc45"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.01.20-192943/wendy-cli-linux-static-musl-aarch64-2026.01.20-192943.tar.gz"
      sha256 "b2d79b5de2a24618d84a9cc5b230ef9faf4df3d69de31a111d031adb4835d7ae"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.01.20-192943/wendy-cli-linux-static-musl-x86_64-2026.01.20-192943.tar.gz"
      sha256 "62137886ad7dc4d6ce4b7c3f0ca5bd12066f9173b2066596f914d9f9586badba"
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
