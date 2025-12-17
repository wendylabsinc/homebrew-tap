class Wendy < Formula
  desc "CLI for building and running WendyOS applications"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-2025.12.15-163638"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "1dc073206837862a6145c40271de6c0735a966eedd9f56d0b14d04c2267f1093"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.12.17-110210/wendy-cli-macos-arm64-2025.12.17-110210.tar.gz"
    sha256 "4521a50154e3165bf492a40042c869b8f25b8aeaa1ebaf37add59db3e37242d3"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.12.17-110210/wendy-cli-linux-static-musl-aarch64-2025.12.17-110210.tar.gz"
      sha256 "e2b5424bd3204e1d3136f95dcaaf03c515f2c6156a4f15ffec5a67b5699d0bc1"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.12.17-110210/wendy-cli-linux-static-musl-x86_64-2025.12.17-110210.tar.gz"
      sha256 "76535a38b55f5dc6451f57c820439e23391d600b50fa4f0b17f9c4f762ed4149"
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

  def caveats
    <<~EOS
      Attention: The Wendy CLI collects anonymous analytics.
      They help us understand which commands are used most, identify common errors, and prioritize improvements.
      Analytics are enabled by default. If you'd like to opt-out, use the following command:
        wendy analytics disable
      Or, set the following environment variable:
        WENDY_ANALYTICS=false
    EOS
  end

  test do
    # TODO: It would be better to actually build something, instead of just checking the help text.
    system bin/"wendy", "--help"
    assert_match "OVERVIEW: Wendy CLI", shell_output("#{bin}/wendy --help")
  end
end
