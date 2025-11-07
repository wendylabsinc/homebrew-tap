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
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.11.07-150616/wendy-cli-macos-arm64-2025.11.07-150616.tar.gz"
    sha256 "c7999a552d207088d4812eb6ea4025829f0a760bccf9ea3e340ea2938dd8e7f0"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.11.07-150616/wendy-cli-linux-static-musl-aarch64-2025.11.07-150616.tar.gz"
      sha256 "ac4181dc4749a86eb34e2ec5cec8996e6d118a2f0f671fe48cb94fd36b6a332c"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.11.07-150616/wendy-cli-linux-static-musl-x86_64-2025.11.07-150616.tar.gz"
      sha256 "30396a82a353587b9aefb124f18023a60d0463e9d92afba50343a7f53934a8a0"
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
