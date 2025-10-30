class Wendy < Formula
  desc "CLI for building and running WendyOS applications"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-2025.10.30-175104"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "548cdb8ff71d74a4cb4f7029a5163dff659694f0b9980ad388e0478bc67687b1"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.10.30-175104/wendy-cli-macos-arm64-2025.10.30-175104.tar.gz"
    sha256 "b5966a651426afdd1d428b8865910426039fd45701cc8090ac0d134793b8de32"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.10.30-175104/wendy-cli-linux-static-musl-aarch64-2025.10.30-175104.tar.gz"
      sha256 "4bd47cb7024bf43c61c23f5e7ef61697db57ca4f70f46ed4fc5d002ca4d5569e"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.10.30-175104/wendy-cli-linux-static-musl-x86_64-2025.10.30-175104.tar.gz"
      sha256 "76dcd8e7fa87b1ad831d57d12b0be2f9b1766bf7d1fcf6b2eaa61f7a0a43b74a"
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
