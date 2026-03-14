class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.03.14-114630"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "3702ee93d9465ed506e3caa29ea537b820f7ebebb69fde77a36bc98e33d158fe"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.14-114630/wendy-cli-darwin-arm64-2026.03.14-114630.tar.gz"
    sha256 "2d5bd3d89792128db04ced1b9ea2bd8ecc10423648f210698ea0c9e6963152f6"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.14-114630/wendy-cli-linux-arm64-2026.03.14-114630.tar.gz"
      sha256 "18df6d445dcc7dc705aac952170243125a516e13d2fb750a57a9732507fe03fe"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.14-114630/wendy-cli-linux-amd64-2026.03.14-114630.tar.gz"
      sha256 "c3e15c7be4c1a543fdea9f31b3be5ce98c90a556ad6ce61b308c312e713aabbc"
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
