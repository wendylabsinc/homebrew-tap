class Wendy < Formula
  desc "CLI for building and running WendyOS applications"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-2025.11.03-185608"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "6a2f241d38f1bad2d31784a389ee8304a48746f1d70f2fb215f83bce92e31ab3"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.11.03-185608/wendy-cli-macos-arm64-2025.11.03-185608.tar.gz"
    sha256 "e129c28dd2b01a3ddbd4201591a33bce5e02086a2b5d4a3bb1828bbde33f7976"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.11.03-185608/wendy-cli-linux-static-musl-aarch64-2025.11.03-185608.tar.gz"
      sha256 "52384f1b0a4e6649380c7cb2d04cacfbcfa3ee7d2a30f6e073121b48b08c03c7"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.11.03-185608/wendy-cli-linux-static-musl-x86_64-2025.11.03-185608.tar.gz"
      sha256 "f10d2ffc4d37f7f8c25934900d959e2f934b583095ea99db0e82d65854cfadd9"
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

  test do
    # TODO: It would be better to actually build something, instead of just checking the help text.
    system bin/"wendy", "--help"
    assert_match "OVERVIEW: Wendy CLI", shell_output("#{bin}/wendy --help")
  end
end
