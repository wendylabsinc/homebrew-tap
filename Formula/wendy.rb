class Wendy < Formula
  desc "CLI for building and running WendyOS applications"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-2026.03.10-165737"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "0000000000000000000000000000000000000000000000000000000000000000"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.10-165737/wendy-cli-darwin-arm64-2026.03.10-165737.tar.gz"
    sha256 "359cb9d8019885bab70966e24c0ae684ffa302418cef99a6d85259528a9b6263"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.10-165737/wendy-cli-linux-arm64-2026.03.10-165737.tar.gz"
      sha256 "4efa807ddd1279229ba65ce0b39a4273e660c7f093dff73af0198db95eafd23f"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.10-165737/wendy-cli-linux-amd64-2026.03.10-165737.tar.gz"
      sha256 "f0cb9552f1ced6e140dad4313271d1f00db4013fba214a1fb1b9568f1289dda8"
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
    assert_match "OVERVIEW: Wendy CLI", shell_output("#{bin}/wendy --help")
  end
end
