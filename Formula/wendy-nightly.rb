class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.05.17-190009"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "690a5aba6d481c4f55608c83baee8f61a53292ed7f70466674af467b53863ee0"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.05.17-190009/wendy-cli-darwin-arm64-2026.05.17-190009.tar.gz"
    sha256 "13f2ac7d40862b34305b491dd052c6b46d525ce588d26cc1730e1e90c35319d3"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.05.17-190009/wendy-cli-linux-arm64-2026.05.17-190009.tar.gz"
      sha256 "4075c99d5b0018aa6ac2347cc1cd703b7d37c8bd19dfa9a34e209a7e9fac04d0"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.05.17-190009/wendy-cli-linux-amd64-2026.05.17-190009.tar.gz"
      sha256 "272ae9cdb6745d1567b2bab145187e09b3d9b925cd341060b8bd12d8b733c143"
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
