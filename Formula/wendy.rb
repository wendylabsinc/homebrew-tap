class Wendy < Formula
  desc "CLI for building and running WendyOS applications"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-2026.01.27-103450"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "c882ba2ebbe7fbca62bace0c4ca20b94be1b226d7092e12ad234e7792cdf3d00"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.01.27-194133/wendy-cli-macos-arm64-2026.01.27-194133.tar.gz"
    sha256 "92ca87ab0ea5a6c7b902f9324696fa7b7aa1fbb4cb9045800370cf521c345127"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.01.27-194133/wendy-cli-linux-static-musl-aarch64-2026.01.27-194133.tar.gz"
      sha256 "daea27c678b727d190163dc41e41729d86ff02e94720ec46a3ad55c19a6303d9"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.01.27-194133/wendy-cli-linux-static-musl-x86_64-2026.01.27-194133.tar.gz"
      sha256 "75591d8dc5759c05f7b2334adad24fdf2af7b57b5492171db14dc80f8534a63f"
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
