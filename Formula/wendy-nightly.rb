class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.04.12-204206"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "69bce22b8ff450d0a4ae04b0be1b8b3b0d336cee4faba707876ef3193f803a37"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.12-204206/wendy-cli-darwin-arm64-2026.04.12-204206.tar.gz"
    sha256 "0ee7b8e65fe6921f69f49c70b83bd02629bd8e8ce18fa535363c2620a0e6dafe"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.12-204206/wendy-cli-linux-arm64-2026.04.12-204206.tar.gz"
      sha256 "f32ce69aba416f9207fd29e8be208849e2a2e53baf9c769dc73ab2a2de63cefd"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.12-204206/wendy-cli-linux-amd64-2026.04.12-204206.tar.gz"
      sha256 "c46ab2304de5676f0712f6619f0db65bb1e741c81832495fd1d676f9953a251f"
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
