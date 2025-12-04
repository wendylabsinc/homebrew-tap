class Wendy < Formula
  desc "CLI for building and running WendyOS applications"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-2025.12.02-175042"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "6e7287ae288907e6bab5f8bcaa2020874eea35fc8c1f6fa62f0b80b7d27c557b"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.12.04-191348/wendy-cli-macos-arm64-2025.12.04-191348.tar.gz"
    sha256 "9be158310ea8def83f719521487c6db049a12fb6651f7633ac63bf0df53bc0b1"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.12.04-191348/wendy-cli-linux-static-musl-aarch64-2025.12.04-191348.tar.gz"
      sha256 "7679f0a838ae3664004bb796879e52e247bfa5c11f1472b3f1e0a231fd0cde98"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.12.04-191348/wendy-cli-linux-static-musl-x86_64-2025.12.04-191348.tar.gz"
      sha256 "92f23caa5d3a3b0f67e652e9112244ea75024def3429f747241351391bcf17de"
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
