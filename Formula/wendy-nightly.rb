class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.04.08-195953"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "202b7a5b3ac07045183cce25b96354e7a5ec23e1978f10c0afd41a32b1188f2d"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.08-195953/wendy-cli-darwin-arm64-2026.04.08-195953.tar.gz"
    sha256 "02988a501cf9ab137a4bf57b6620b546b0651900f72473dbbef283a5ad45a3b5"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.08-195953/wendy-cli-linux-arm64-2026.04.08-195953.tar.gz"
      sha256 "4758766fc07a2c2f7e0417ee32de8e4c5764de655eb526e3d9ae878234a9ee69"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.08-195953/wendy-cli-linux-amd64-2026.04.08-195953.tar.gz"
      sha256 "24993ca1fca939c314350ae15dcd6027b985839f87ba63379f810312f9573839"
    end
  end

  conflicts_with "wendy", because: "both install a `wendy` binary"

  def install
    # Install pre-built binaries (all platforms)
    bin.install "wendy"
    bin.install "wendy-helper" if File.exist?("wendy-helper")
    bin.install "wendy-network-daemon" if File.exist?("wendy-network-daemon")

    # Install macOS-specific bundle with resources (plist files, etc) if present
    bundle_path = "wendy-agent_wendy.bundle"
    (lib/"wendy").install bundle_path if File.directory?(bundle_path)

    # Generate and install shell completions
    generate_completions_from_executable(bin/"wendy", "completion")
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
    system bin/"wendy", "--help"
    assert_match "OVERVIEW: Wendy CLI", shell_output("#{bin}/wendy --help")
  end
end
