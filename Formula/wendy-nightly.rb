class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.04.29-210337"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "e10a3249a6508e7fbea730c4e58877440c7cdf2d3749f23e8becb9d34508c2a6"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.29-210337/wendy-cli-darwin-arm64-2026.04.29-210337.tar.gz"
    sha256 "08d2e097c49216a8e463d975da72fe0abedeac3ce4c97be8dd0ab1a9e0b4bed0"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.29-210337/wendy-cli-linux-arm64-2026.04.29-210337.tar.gz"
      sha256 "3f12b73c536fa92491aa7ca03678d063e97dfa377a462c56fd68f23df9c961a2"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.29-210337/wendy-cli-linux-amd64-2026.04.29-210337.tar.gz"
      sha256 "7e047321d427f58bc43613bc2348a09b13c2cb7811c0dd0a86bb1e038e930265"
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
