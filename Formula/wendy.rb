class Wendy < Formula
  desc "CLI for building and running WendyOS applications"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-2025.10.31-192229"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "cb4e1cc8bde6847fa23eb70f97bda1dfb5df42f14015490716ed41aca2a90542"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.10.31-192229/wendy-cli-macos-arm64-2025.10.31-192229.tar.gz"
    sha256 "bf6dfdec933aad0fc6cebabaf40dcb0cbd070b223b8e7cd75b042ebb19a73341"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.10.31-192229/wendy-cli-linux-static-musl-aarch64-2025.10.31-192229.tar.gz"
      sha256 "d8b67d74474bf6276d749be9537dda9e72c7c2ce07f7305bce74f29f56aad0e5"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.10.31-192229/wendy-cli-linux-static-musl-x86_64-2025.10.31-192229.tar.gz"
      sha256 "fbe80b16958cfe3518d234ce44d7eda61664d4bc79582645f258d299e8880a90"
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
