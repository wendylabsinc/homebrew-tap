class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.04.04-170513"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "5a6f948723a1ecb638584349db28e5a9e7fb71d1af0b9d6cb1880601b4cffc3d"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.04-170513/wendy-cli-darwin-arm64-2026.04.04-170513.tar.gz"
    sha256 "ee4748300238666854451dc53fe5f4374397e563cbcacb8877ab46754e4ba0c1"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.04-170513/wendy-cli-linux-arm64-2026.04.04-170513.tar.gz"
      sha256 "3aba21d5582a5ac773013802a7515711800ad5789574d5e88c53a4fc01fc5bed"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.04-170513/wendy-cli-linux-amd64-2026.04.04-170513.tar.gz"
      sha256 "5fe4c95b10e5f8c3163c1222f75c0a2b56f75fd1a5aa98a87474bad84f0e44cf"
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
