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
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.11.03-221742/wendy-cli-macos-arm64-2025.11.03-221742.tar.gz"
    sha256 "b8835d96d07ae955c978a9a928e8b09f0db4707a2231956987a048dc5ec6b214"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.11.03-221742/wendy-cli-linux-static-musl-aarch64-2025.11.03-221742.tar.gz"
      sha256 "42987449b171327dc1c7db598e0ea544bcf41670c746fc9125d8e301e16e02f4"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.11.03-221742/wendy-cli-linux-static-musl-x86_64-2025.11.03-221742.tar.gz"
      sha256 "be178411e65e17ac969f428cab8159d0e270a063f3bc7da178d6d037480a8b4d"
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
