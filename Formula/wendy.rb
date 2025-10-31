class Wendy < Formula
  desc "CLI for building and running WendyOS applications"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-2025.10.31-160140"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "1b685463c6569790cfb2cf6d4da41b52ae331f285a71a2a493b0a3b28898b5ae"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.10.31-160140/wendy-cli-macos-arm64-2025.10.31-160140.tar.gz"
    sha256 "eb92ba7676c0e2913f99060087f1561337d0c4f55a37549909de877104daa184"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.10.31-160140/wendy-cli-linux-static-musl-aarch64-2025.10.31-160140.tar.gz"
      sha256 "4ac5e86b06a93f203521b2034bef255ac11bda9692c16b91823004c727bb5cf0"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.10.31-160140/wendy-cli-linux-static-musl-x86_64-2025.10.31-160140.tar.gz"
      sha256 "f4bf1448e4adc4a3ec282bdfd9bec9c53cbfff7360a8812add958caa2e6aaa57"
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
