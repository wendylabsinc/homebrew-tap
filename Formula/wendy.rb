class Wendy < Formula
  desc "CLI for building and running WendyOS applications"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-2025.11.05-201652"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "6f9493ca466719fb4ec110bbdf68858cf85a8e8667306a56050f1d63e6dcb908"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.11.05-230329/wendy-cli-macos-arm64-2025.11.05-230329.tar.gz"
    sha256 "71bbab8743a3d29b8b0e2ca529b442425a7a515e8e33278c44c3bc3ef61cf11a"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.11.05-230329/wendy-cli-linux-static-musl-aarch64-2025.11.05-230329.tar.gz"
      sha256 "ffb0dbd332db5821d8f6a880bbf7bc75de4c418d8131d3e23b5b0f8d212b0b5d"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.11.05-230329/wendy-cli-linux-static-musl-x86_64-2025.11.05-230329.tar.gz"
      sha256 "38ef9b63a54207499902b4d2e90bef13d193684ca260a8a27ce77f38f7bb38c1"
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
