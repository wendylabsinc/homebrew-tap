class Wendy < Formula
  desc "CLI for building and running WendyOS applications"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-2025.11.03-194709"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "14d4f42a44abdb698a03835dd8cd5b3de46637ed519fd6eff3bb409ef129be9f"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.11.04-185712/wendy-cli-macos-arm64-2025.11.04-185712.tar.gz"
    sha256 "70121ba891466b525196b006ce454cf4ff559651cd26b75a2d3927d2e76c88bd"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.11.04-185712/wendy-cli-linux-static-musl-aarch64-2025.11.04-185712.tar.gz"
      sha256 "d4c152ae12e4acca350286cfbd2dd675d4cd10dde90dda0d8a440c9f3ff88111"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.11.04-185712/wendy-cli-linux-static-musl-x86_64-2025.11.04-185712.tar.gz"
      sha256 "f5db4ddd936481752176de552c17bd36de80c14780897d838e299eb2a0abf400"
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
