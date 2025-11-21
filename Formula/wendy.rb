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
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.11.21-090144/wendy-cli-macos-arm64-2025.11.21-090144.tar.gz"
    sha256 "d14df5cfb192fc5e79cb11b76d5789d9fa8d7545aaa8dfc911b7c9b9ace0ce83"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.11.21-090144/wendy-cli-linux-static-musl-aarch64-2025.11.21-090144.tar.gz"
      sha256 "266d8b5668987708c079793cd3049db9aa5081c8c273e3b0beed2ba5d47a5b34"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.11.21-090144/wendy-cli-linux-static-musl-x86_64-2025.11.21-090144.tar.gz"
      sha256 "988802d1bb2e52cde40108ca57d94feebda45c7a87e7bc05c0828b5edaae7db2"
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
