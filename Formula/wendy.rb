class Wendy < Formula
  desc "CLI for building and running WendyOS applications"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-2026.05.18-104720"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "5aa9bda44b8fea9ec4296c50f9eb0a94d984e3f9adc6750f6d1fab58b7ae29ee"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.05.18-104720/wendy-cli-darwin-arm64-2026.05.18-104720.tar.gz"
    sha256 "2bd43efbcfe7285bb01e58e52d01453688f46eb8990ff159952a2dea40b0f0ea"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.05.18-104720/wendy-cli-linux-arm64-2026.05.18-104720.tar.gz"
      sha256 "b99184c75163b00ccff26a64d56d0ae3ebf30835672570638bcf6b821e544f51"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.05.18-104720/wendy-cli-linux-amd64-2026.05.18-104720.tar.gz"
      sha256 "f70a9016d50a830ba3014374c4241d843cc05f26c1184e86d60a361b97359013"
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
