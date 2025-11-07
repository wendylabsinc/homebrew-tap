class Wendy < Formula
  desc "CLI for building and running WendyOS applications"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-2025.11.07-150616"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "e43ac8d94985d2d6657f57db08809138d45e7e9d3f499d16834730ce2e5b3ef5"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.11.07-153355/wendy-cli-macos-arm64-2025.11.07-153355.tar.gz"
    sha256 "2f9c79a57f80543512136d5fc7e492c39ca1b9830b1090dbb21f17b19c3434a8"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.11.07-153355/wendy-cli-linux-static-musl-aarch64-2025.11.07-153355.tar.gz"
      sha256 "324a2275604cf8f5332504d80c58a1cdde95fc905ee7a28561c30ce9be5d3993"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.11.07-153355/wendy-cli-linux-static-musl-x86_64-2025.11.07-153355.tar.gz"
      sha256 "fa659bc0464ca2b5daad17901396e35645748b8866010334f325ee76d1ee0eef"
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
