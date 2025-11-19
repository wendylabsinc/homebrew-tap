class Wendy < Formula
  desc "CLI for building and running WendyOS applications"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-2025.11.14-193621"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "57bae3ed47e0edbeb2069e56eba14c2b59462ec822996b0b46ad21375e932af4"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.11.19-212607/wendy-cli-macos-arm64-2025.11.19-212607.tar.gz"
    sha256 "993cbe68ed1b748a43e4ec2eb12b10ab65d78bf0556c44635bb6b1dbfa7405f6"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.11.19-212607/wendy-cli-linux-static-musl-aarch64-2025.11.19-212607.tar.gz"
      sha256 "22ff21a4c4a250a2ffb74f4abc51a544d0f09079ac8817f320360e361c2a80ed"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.11.19-212607/wendy-cli-linux-static-musl-x86_64-2025.11.19-212607.tar.gz"
      sha256 "00be2fb654858fd73c1e088ef2dfb17f7becbd39dd266d665c0cc3e6774381ee"
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
