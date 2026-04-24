class Wendy < Formula
  desc "CLI for building and running WendyOS applications"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-2026.04.24-131348"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "8e5ee92002248877d7e76abe2b82f07e4a2e38001dcb22812c577c47d5858d2a"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.24-131348/wendy-cli-darwin-arm64-2026.04.24-131348.tar.gz"
    sha256 "1475feff316c1d0b05659a960a7395d56d46d595afe794e220af7a341a71c0c2"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.24-131348/wendy-cli-linux-arm64-2026.04.24-131348.tar.gz"
      sha256 "24764de5b843b558360045b6df4441e2219c748919d4f424a2fc1b85814d2a3f"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.24-131348/wendy-cli-linux-amd64-2026.04.24-131348.tar.gz"
      sha256 "64a85207bbf8daf27d3b966d2cf6ececadcf48d6e76593fdec850fa2520dd636"
    end
  end

  conflicts_with "wendy-nightly", because: "both install a `wendy` binary"

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
    # TODO: It would be better to actually build something, instead of just checking the help text.
    system bin/"wendy", "--help"
    assert_match "wendy [command]", shell_output("#{bin}/wendy --help")
  end
end
