class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.05.18-213432"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "54bab75c6b4ab52eade7673e09acb1dd1230a69b12b33228738992290797699e"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.05.18-213432/wendy-cli-darwin-arm64-2026.05.18-213432.tar.gz"
    sha256 "9f6df420e5d7eb02e7422139f4f3ca4870225048dc048ba4f0f4d642300eec86"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.05.18-213432/wendy-cli-linux-arm64-2026.05.18-213432.tar.gz"
      sha256 "5ff8f04c25995e18b943c94f299383f4a09984f36a003fa81c5fb73cbd170ea3"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.05.18-213432/wendy-cli-linux-amd64-2026.05.18-213432.tar.gz"
      sha256 "6a84f0e30f93534cdf773eada5ea114bab456f9fdd37236d847d3ebbd632c16c"
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
