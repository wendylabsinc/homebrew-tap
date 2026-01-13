class Wendy < Formula
  desc "CLI for building and running WendyOS applications"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-2026.01.07-083101"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "7cb5f17869a46e1343bb684a83cc93dc889b7df1a57685899e080bbd13334f5f"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.01.13-093613/wendy-cli-macos-arm64-2026.01.13-093613.tar.gz"
    sha256 "1fad15bb6eb3aad260a7a06c91dfff6e08c6dd8e7578569e769adb0f4a923779"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.01.13-093613/wendy-cli-linux-static-musl-aarch64-2026.01.13-093613.tar.gz"
      sha256 "81f74a9242e9fc921e88880e6941a8d21b5e6731c6a1f52eea8cca32e239ef86"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.01.13-093613/wendy-cli-linux-static-musl-x86_64-2026.01.13-093613.tar.gz"
      sha256 "4fc171643feb7984f442ad6eb60e9b429c570bf5e2e0f09c649980bd559a40fc"
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
