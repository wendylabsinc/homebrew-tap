class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.05.04-080718"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "377c2093a227fc386136f7a1541a4588ca2fa4dbf11035045db50201ab66ceed"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.05.04-080718/wendy-cli-darwin-arm64-2026.05.04-080718.tar.gz"
    sha256 "e351a71424736497965542c02d7a30f2425796307336daf8eb2373f3ab12c851"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.05.04-080718/wendy-cli-linux-arm64-2026.05.04-080718.tar.gz"
      sha256 "e943f0c0195b7fbe513b21eccdb054cbe3f38fb9b3daf6b3a32773c04a640fb0"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.05.04-080718/wendy-cli-linux-amd64-2026.05.04-080718.tar.gz"
      sha256 "8e479bc44771a22f9b8fbd1e92f8ed5efd1866385cefbb702b6cbcd5ded2fda9"
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
