class Wendy < Formula
  desc "CLI for building and running WendyOS applications"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.10.30-161630/wendy-cli-macos-arm64-2025.10.30-161630.tar.gz"
    sha256 "902930d34ec0fc384f13b9fc7b99411890b17f56ff9658300a934a9a6335996b"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.10.30-161630/wendy-cli-linux-static-musl-aarch64-2025.10.30-161630.tar.gz"
      sha256 "4bd47cb7024bf43c61c23f5e7ef61697db57ca4f70f46ed4fc5d002ca4d5569e"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.10.30-161630/wendy-cli-linux-static-musl-x86_64-2025.10.30-161630.tar.gz"
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
