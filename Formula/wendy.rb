class Wendy < Formula
  desc "CLI for building and running WendyOS applications"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-2025.11.24-205223"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "fdaa4ad355d283d154e68897569f12d6321ce4697c23d89740b7cfc7a986aefd"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.11.24-213447/wendy-cli-macos-arm64-2025.11.24-213447.tar.gz"
    sha256 "e9baf8b2797966c2c23bb4015d47203128770f5ceac279e9be119ea0d9e70f74"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.11.24-213447/wendy-cli-linux-static-musl-aarch64-2025.11.24-213447.tar.gz"
      sha256 "4b18066dff00828d4882d487362dac13ce5c4b0a37e6850564a968ad17066952"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.11.24-213447/wendy-cli-linux-static-musl-x86_64-2025.11.24-213447.tar.gz"
      sha256 "28050bfde91d377f21620b626b61c925e88f941b1cb2175c8d26704ad6e1f69b"
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
