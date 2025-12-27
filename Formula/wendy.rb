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
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.12.27-184432-dev/wendy-cli-macos-arm64-2025.12.27-184432-dev.tar.gz"
    sha256 "65c8e339acbf6a6d5350bcb3269a3c4e7aa5e86b62a41db9684d8297d5582837"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.12.27-184432-dev/wendy-cli-linux-static-musl-aarch64-2025.12.27-184432-dev.tar.gz"
      sha256 "27c25b4a10070a81dca7544546acc1f06036f1f66ae86641f85aaae8d1416c30"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.12.27-184432-dev/wendy-cli-linux-static-musl-x86_64-2025.12.27-184432-dev.tar.gz"
      sha256 "a71bacadae02444943b9571cd64a4ddd01169d2da2b368b2a899f486803dbae0"
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
