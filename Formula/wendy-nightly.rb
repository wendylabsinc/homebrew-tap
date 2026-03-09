class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.03.09-185220"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "bf75e1053bba4d038bc8154a6c2ea5df7984e0e9c76e47209b787186b0def774"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.09-185220/wendy-cli-darwin-arm64-2026.03.09-185220.tar.gz"
    sha256 "0694189eb506be1a3f76ab4520138520f58d906b4f73641391cb87ef4aa191cb"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.09-185220/wendy-cli-linux-arm64-2026.03.09-185220.tar.gz"
      sha256 "a8632d2ce608c93b76a78568e671b579bb014fd4432152f8cf3ad271a2b5d547"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.09-185220/wendy-cli-linux-amd64-2026.03.09-185220.tar.gz"
      sha256 "90830b1fbe072d5d3663bcbc6d4bd97b571a47b0e54f43271823d7a5d45eeb02"
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
