class Wendy < Formula
  desc "CLI for building and running WendyOS applications"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-2026.04.30-211221"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "6989a548992e00372b59d507e8eb17cd96ae1f93d72e7e41624d7b1f9aba9c0f"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.30-211221/wendy-cli-darwin-arm64-2026.04.30-211221.tar.gz"
    sha256 "97ed6fb411c71eab4231cadc657a52a4af250913ef279661da36f263bb0a142e"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.30-211221/wendy-cli-linux-arm64-2026.04.30-211221.tar.gz"
      sha256 "023528a7234c7661a9e3f69ff1bedb3c0e0b30453a4095f4e442bacf9fde9aa3"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.30-211221/wendy-cli-linux-amd64-2026.04.30-211221.tar.gz"
      sha256 "49d5ccfb636ee6b7bd78b037625e843ee0d5aa857ad9789ff9dd782d89afb1f2"
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
