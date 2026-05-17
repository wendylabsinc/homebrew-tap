class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.05.17-182148"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "f1594f679e76b48b5ffbc839560c568b15312166f9f2c98149ddebd83820dd9d"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.05.17-182148/wendy-cli-darwin-arm64-2026.05.17-182148.tar.gz"
    sha256 "43ffadd512d696803fe2fb702ffb4f5ad17c214455e6f21ce48c682c5509c3ba"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.05.17-182148/wendy-cli-linux-arm64-2026.05.17-182148.tar.gz"
      sha256 "921b4405188aa27c999967eeca1dc83cdf5173b168482d490a022b3367927aba"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.05.17-182148/wendy-cli-linux-amd64-2026.05.17-182148.tar.gz"
      sha256 "c5cc7e6d8985662009871b7104597d0275334c0f7b29f26f9721078d4fe7ced8"
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
