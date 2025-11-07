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
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.11.07-153350/wendy-cli-macos-arm64-2025.11.07-153350.tar.gz"
    sha256 "21e6b79ddf575693ded172cdde57302ad9b6ef43744735d91f7ce949b9de7faf"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.11.07-153350/wendy-cli-linux-static-musl-aarch64-2025.11.07-153350.tar.gz"
      sha256 "3b3f727a933ae3f8fa7a9c99e3ae3d2d2e8b4505beecd3136c3648f7bb6c7b02"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.11.07-153350/wendy-cli-linux-static-musl-x86_64-2025.11.07-153350.tar.gz"
      sha256 "5727e474551a6dbf62adc7219bffe288075a2ab85518eca7666f2e9cdef612a9"
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
