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
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.11.24-000357/wendy-cli-macos-arm64-2025.11.24-000357.tar.gz"
    sha256 "53839d2bc9a988dde670b10e3962b05668e9c1d5a991214e1ed47a76b79a4ea2"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.11.24-000357/wendy-cli-linux-static-musl-aarch64-2025.11.24-000357.tar.gz"
      sha256 "76b4fcde669e28f640e4e57020ab8006b1c62059984e0e42c55501e4b5a17b68"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.11.24-000357/wendy-cli-linux-static-musl-x86_64-2025.11.24-000357.tar.gz"
      sha256 "ca7b47cc63f472fbb586a9c0cd8ada361e7bb0b30ded190f3b3bf310d9fc05c0"
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
