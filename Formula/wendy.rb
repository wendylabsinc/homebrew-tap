class Wendy < Formula
  desc "CLI for building and running WendyOS applications"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-2025.11.06-001635"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "476efec9631e719b27f70804982aa7cfad4dde135d59d19fda28cb7e9e6c0b6c"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.11.06-001635/wendy-cli-macos-arm64-2025.11.06-001635.tar.gz"
    sha256 "9d3b50d2ccbf9d2d032cd893ae9587edcd30672ed4cc91a6b9473b46b9f7b09b"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.11.06-001635/wendy-cli-linux-static-musl-aarch64-2025.11.06-001635.tar.gz"
      sha256 "f5e995bb071af5a8031a24dbd3f523a7387be240921c6514be0f85fdb644b4cb"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.11.06-001635/wendy-cli-linux-static-musl-x86_64-2025.11.06-001635.tar.gz"
      sha256 "f5c16a95a384e12680a234b13077700033c430bbaeb7555409f813d81930b893"
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
