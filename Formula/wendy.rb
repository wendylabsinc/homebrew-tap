class Wendy < Formula
  desc "CLI for building and running WendyOS applications"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-2025.11.14-193621"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "57bae3ed47e0edbeb2069e56eba14c2b59462ec822996b0b46ad21375e932af4"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.11.14-193621/wendy-cli-macos-arm64-2025.11.14-193621.tar.gz"
    sha256 "e7c771d0599fef9f7b502526444c1fc4bf4a51d9fd91f638ccdbbfb89732e380"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.11.14-193621/wendy-cli-linux-static-musl-aarch64-2025.11.14-193621.tar.gz"
      sha256 "b2d3a0fc82df36ba3839a4f900b0bd5c1bc1c869219ed2e27d5f3573bfbfc5b9"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.11.14-193621/wendy-cli-linux-static-musl-x86_64-2025.11.14-193621.tar.gz"
      sha256 "17d74458f466b9b8d06a8e38524f8b68d5af120b4a98b82b107076d6ae13c408"
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

  def post_install
    system "swiftly", "install", "6.2.1"

    # Install the Swift SDK if not already installed
    if not File.exist?("~/.swiftpm/swift-sdks/6.2.1-RELEASE_wendyos_aarch64.artifactbundle")
      system "swift", "sdk", "install", "https://github.com/wendylabsinc/wendy-swift-tools/releases/download/0.3.0/6.2.1-RELEASE_wendyos_aarch64.artifactbundle.zip", "--checksum", "d1f198fe5ce827e4f7f0d812a4c180c0b09831affafe520a254d4f0ce0c53ae9"
    end
  end

  test do
    # TODO: It would be better to actually build something, instead of just checking the help text.
    system bin/"wendy", "--help"
    assert_match "OVERVIEW: Wendy CLI", shell_output("#{bin}/wendy --help")
  end
end
