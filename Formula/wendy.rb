class Wendy < Formula
  desc "CLI for building and running WendyOS applications"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-2025.12.21-091451"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "0987650f119d81ea6f131116f65d0571d71d374c2d1d5a5d75fe6e8eb9ab8f83"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.12.26-171040/wendy-cli-macos-arm64-2025.12.26-171040.tar.gz"
    sha256 "3c3fc6fffe0b474f9432a8e5ce9f0ab8c6436f35d50ee231e87e16bcbf063ffb"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.12.26-171040/wendy-cli-linux-static-musl-aarch64-2025.12.26-171040.tar.gz"
      sha256 "5d88bc719d03daa9e1207ac688063d043c65bc8875e750cd03672163bb9fca43"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.12.26-171040/wendy-cli-linux-static-musl-x86_64-2025.12.26-171040.tar.gz"
      sha256 "7b9463f521d58607ddab957048bed18c4d119de14b7fce18044a2a64b25b17d5"
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
