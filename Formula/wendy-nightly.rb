class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.03.18-200617"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "767a1aabecee52fab8ade5e7f11dac0cd3407c95dfdd669de2d49d16aa8476e5"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.18-200617/wendy-cli-darwin-arm64-2026.03.18-200617.tar.gz"
    sha256 "e6c59cf6e26155450e62172f2bd064bc74cd61308b59110d51975747378b59e9"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.18-200617/wendy-cli-linux-arm64-2026.03.18-200617.tar.gz"
      sha256 "6e5b1af7830ecba95e77981083b281fa6f7e953ba2370563409a23ac6ee104f0"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.18-200617/wendy-cli-linux-amd64-2026.03.18-200617.tar.gz"
      sha256 "cfd9738ae0a4cc736f2089c4c6105eae2ca65893bbdbe0484ed40dcfba7a2665"
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
