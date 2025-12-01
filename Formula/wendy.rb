class Wendy < Formula
  desc "CLI for building and running WendyOS applications"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-2025.11.24-213447"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "4b544fb17c4b2770c027d8776694322e8ffa7257499e69d9bbe7f69e66a0eee4"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.12.01-191725/wendy-cli-macos-arm64-2025.12.01-191725.tar.gz"
    sha256 "0edaa5b4121358f744482ef3161235c49e4af4ac09ff4ac5d4007517519fb896"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.12.01-191725/wendy-cli-linux-static-musl-aarch64-2025.12.01-191725.tar.gz"
      sha256 "1c78c5d76fd101f7d695ee062bee399c582d69a20bc4d56cdeb2dd66b313482c"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.12.01-191725/wendy-cli-linux-static-musl-x86_64-2025.12.01-191725.tar.gz"
      sha256 "5f3c614885c28343854dc6ca5cab09d2a5caee4c882c51af0b8806cfaa92c953"
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
