class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.03.27-162629"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "f01897feb7a6103aadad2aab4572cc9b37125b2ab274064a32a88dd02f914e7c"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.27-162629/wendy-cli-darwin-arm64-2026.03.27-162629.tar.gz"
    sha256 "d8efe8bb2072d60555a14c30d417f0145f178c255a2459719934bc2d06e2b4cf"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.27-162629/wendy-cli-linux-arm64-2026.03.27-162629.tar.gz"
      sha256 "4a59d6a01d04be5b690bb1c691dc7f5ee749adc84d9d1ade9aeb67e4fc935d85"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.27-162629/wendy-cli-linux-amd64-2026.03.27-162629.tar.gz"
      sha256 "81a102cbe2d3670ecca2db8a36f9454ad6d8b9dc91cc1a090096ce09c9bc1b97"
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
