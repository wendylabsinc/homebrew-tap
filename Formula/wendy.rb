class Wendy < Formula
  desc "CLI for building and running WendyOS applications"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-2025.11.09-122010"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "99c2df5c95e4579fc3fca357b62e6039441bd463d0b2a70e1aeb1850cac00ccf"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.11.11-231729/wendy-cli-macos-arm64-2025.11.11-231729.tar.gz"
    sha256 "b9f97d2ce552bba097f3e0c9e4d2d607a4eec8623863132bb11387eb4d5418a2"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.11.11-231729/wendy-cli-linux-static-musl-aarch64-2025.11.11-231729.tar.gz"
      sha256 "c32ecf3117ff39d2b29bd01020be3f6804b96f9dbed351d1a86393fb6ced74e2"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.11.11-231729/wendy-cli-linux-static-musl-x86_64-2025.11.11-231729.tar.gz"
      sha256 "6a4a0c7f191ba23e449dd513d2064b6f6806646528dec6327b85d6f47be34bb6"
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
