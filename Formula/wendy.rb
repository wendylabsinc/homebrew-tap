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
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.11.24-180727/wendy-cli-macos-arm64-2025.11.24-180727.tar.gz"
    sha256 "d1c855d373f4c04c7fd43ca8adb2d87060dcf2da2fee911168e0c10c86a6f113"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.11.24-180727/wendy-cli-linux-static-musl-aarch64-2025.11.24-180727.tar.gz"
      sha256 "44b5bb0a7a1983fbb2735e2966354a2d5856043502572d8a926f0211a2c3c42a"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.11.24-180727/wendy-cli-linux-static-musl-x86_64-2025.11.24-180727.tar.gz"
      sha256 "860ee2e3ed4c5adfaf2c5306deea42e39e630617da9a364d58609175e927bc42"
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
