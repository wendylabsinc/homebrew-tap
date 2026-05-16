class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.05.16-203012"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "7b7857be19b1da3e999c6c83f7acf8254b53bce685ef50254763277e5b3b8e6a"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.05.16-203012/wendy-cli-darwin-arm64-2026.05.16-203012.tar.gz"
    sha256 "0fed0b2ec95c9a6e446839d25cb408915c8a6dd2b10514415f8f47de312c5e94"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.05.16-203012/wendy-cli-linux-arm64-2026.05.16-203012.tar.gz"
      sha256 "096b0966ed1109e8678aa0f494b897a7b68c2ff3da39cada26c861d026d3cfe7"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.05.16-203012/wendy-cli-linux-amd64-2026.05.16-203012.tar.gz"
      sha256 "de96ad5842dc409ce61f97e7fe30cc9a449a180d08d44dcd4ce955239231764e"
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
