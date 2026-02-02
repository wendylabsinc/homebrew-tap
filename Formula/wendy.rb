class Wendy < Formula
  desc "CLI for building and running WendyOS applications"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-2026.02.01-193144"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "68e9c293d6a88718981d2de808d6ef2b79a09a9ccc06b5fb10a727a2e634f6e4"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.02.02-084631/wendy-cli-macos-arm64-2026.02.02-084631.tar.gz"
    sha256 "f49c0f35396c64cc79fb0d2cb176e7a26d454930fc2a3ab0351fe4c51c5ab47f"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.02.02-084631/wendy-cli-linux-static-musl-aarch64-2026.02.02-084631.tar.gz"
      sha256 "7db0cb921f5a612bd6ee0963a16c41bf84ef7d2eadc2007ca5043bd98a8898c4"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.02.02-084631/wendy-cli-linux-static-musl-x86_64-2026.02.02-084631.tar.gz"
      sha256 "397fe8de2f971776e870abb8dadde736257c1ae59c0453d639e2d2cee5dfd522"
    end
  end

  def install
    # Install pre-built binaries (all platforms)
    bin.install "wendy"
    bin.install "wendy-helper" if File.exist?("wendy-helper")
    bin.install "wendy-network-daemon" if File.exist?("wendy-network-daemon")

    # Install macOS-specific bundle with resources (plist files, etc) if present
    bundle_path = "wendy-agent_wendy.bundle"
    (lib/"wendy").install bundle_path if File.directory?(bundle_path)
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
