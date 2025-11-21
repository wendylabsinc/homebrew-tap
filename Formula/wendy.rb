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
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.11.21-083020/wendy-cli-macos-arm64-2025.11.21-083020.tar.gz"
    sha256 "a87dbc525fb4222b659a3933a0cfb3c7e2393e7f4cc5d37be9f8388f4d0eec4c"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.11.21-083020/wendy-cli-linux-static-musl-aarch64-2025.11.21-083020.tar.gz"
      sha256 "2978c237761097ac8a6f4744a1af34e129db8d192fa6d11e91e0946e617805c5"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.11.21-083020/wendy-cli-linux-static-musl-x86_64-2025.11.21-083020.tar.gz"
      sha256 "6e678ff8e186a2fd45a86d867a37679c21c5e8bd5284f8f3200e44ef74a6f6f8"
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
