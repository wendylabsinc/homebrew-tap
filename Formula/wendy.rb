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
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.02.02-082926/wendy-cli-macos-arm64-2026.02.02-082926.tar.gz"
    sha256 "03770024ff33d800efdb98c51a7563d345372948b1fe9d671f9baa2b3bac6217"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.02.02-082926/wendy-cli-linux-static-musl-aarch64-2026.02.02-082926.tar.gz"
      sha256 "f0d28b6e912215f3632d2bc88972057d6e6bc6101b15c96460873a0d25dcf9bf"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.02.02-082926/wendy-cli-linux-static-musl-x86_64-2026.02.02-082926.tar.gz"
      sha256 "5a3133c45423cc3574f005cd8c777c1f372be4f05e2bae27fb053d4f08238b94"
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
