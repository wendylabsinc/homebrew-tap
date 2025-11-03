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
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.11.03-194709/wendy-cli-macos-arm64-2025.11.03-194709.tar.gz"
    sha256 "38d67bdcfaa3b8e25ce1e93d1cb9a0770b0318dfacf7835bcec466239ca1a3eb"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.11.03-194709/wendy-cli-linux-static-musl-aarch64-2025.11.03-194709.tar.gz"
      sha256 "5cd493a6955c95f54968a584405755dabded2e46469596d64e66ef9acf890a2e"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.11.03-194709/wendy-cli-linux-static-musl-x86_64-2025.11.03-194709.tar.gz"
      sha256 "b1e298e013b587ce993c5a351a6f106e94b0d03b60bf4be4fad98150cb9b69fc"
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
