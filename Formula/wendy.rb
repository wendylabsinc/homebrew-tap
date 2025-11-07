class Wendy < Formula
  desc "CLI for building and running WendyOS applications"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-2025.11.07-150616"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "e43ac8d94985d2d6657f57db08809138d45e7e9d3f499d16834730ce2e5b3ef5"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.11.07-152036/wendy-cli-macos-arm64-2025.11.07-152036.tar.gz"
    sha256 "56728e208b926c42380c908e3e7feeafd525b5c66d54dd95778c60f56170c74c"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.11.07-152036/wendy-cli-linux-static-musl-aarch64-2025.11.07-152036.tar.gz"
      sha256 "621506a8a45999a380d109216e453cbcb7cc652f701c73f32b18b5a6b55d8311"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.11.07-152036/wendy-cli-linux-static-musl-x86_64-2025.11.07-152036.tar.gz"
      sha256 "c5ac7974455de11b7f4d5364da797db44e58830d5b6954fb8819582e42d169ae"
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
