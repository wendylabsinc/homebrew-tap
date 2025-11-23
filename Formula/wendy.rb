class Wendy < Formula
  desc "CLI for building and running WendyOS applications"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-2025.11.20-123048"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "960b04a9aa1b193581b3e3fd149ef190260b5b3a647f1c381c5d8e7ee3f5b921"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.11.23-204514/wendy-cli-macos-arm64-2025.11.23-204514.tar.gz"
    sha256 "b73575f6f2c6308dbf32a89272fb30c79f5318a41685b3c8768c90e1c1ba7b9f"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.11.23-204514/wendy-cli-linux-static-musl-aarch64-2025.11.23-204514.tar.gz"
      sha256 "4e29a4c394b95fe119c17759d8c51c404b02870e51441bbeb436b1952daf8f39"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.11.23-204514/wendy-cli-linux-static-musl-x86_64-2025.11.23-204514.tar.gz"
      sha256 "8c3cbb398a1a5f8d2672ff6a30f7aefeb165b19a5a42889d1702bfdeec16c4f1"
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
