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
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.11.04-185659/wendy-cli-macos-arm64-2025.11.04-185659.tar.gz"
    sha256 "5ed196cdb48ca15d3417d9b5da916b923e8eed85f99b2edf764a11203df11553"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.11.04-185659/wendy-cli-linux-static-musl-aarch64-2025.11.04-185659.tar.gz"
      sha256 "ee4c077feb098c6286f1a1daad8f42623c6aa3e98f46d47abb0ced926bfc9be5"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.11.04-185659/wendy-cli-linux-static-musl-x86_64-2025.11.04-185659.tar.gz"
      sha256 "4cdaf405f78b35893fca3fd5dace24f417b5af761d0052cf26aac83276116497"
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
