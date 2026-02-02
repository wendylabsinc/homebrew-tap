class Wendy < Formula
  desc "CLI for building and running WendyOS applications"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-2026.02.02-084631"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "e1b29cdd4ca16b1c7062602cf2f6ad41993d4690e5607e33803132343c981c6d"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.02.02-090531/wendy-cli-macos-arm64-2026.02.02-090531.tar.gz"
    sha256 "024ba6e20c7ecc84a5dbd48edb843e85c3bb7e4432743b6ad5f2876e4c1f68d2"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.02.02-090531/wendy-cli-linux-static-musl-aarch64-2026.02.02-090531.tar.gz"
      sha256 "228794f9460eb6ecf0469507165fff3332ea14a64d01be7564fe976c5b764d11"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.02.02-090531/wendy-cli-linux-static-musl-x86_64-2026.02.02-090531.tar.gz"
      sha256 "1f72b5e9c60c08a0b0c65df17902e3674eec19da0986104aa9b81276e21e5c45"
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
