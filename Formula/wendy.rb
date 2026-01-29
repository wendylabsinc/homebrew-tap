class Wendy < Formula
  desc "CLI for building and running WendyOS applications"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-2026.01.29-083204"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "cf24ff498a717ccdbaf5aa831540db995651f492b82336016d80bfaad69815cd"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.01.29-083204/wendy-cli-macos-arm64-2026.01.29-083204.tar.gz"
    sha256 "bba97b02a0406b91d193e974505351508dde60875f5388ba104e209677cd0104"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.01.29-083204/wendy-cli-linux-static-musl-aarch64-2026.01.29-083204.tar.gz"
      sha256 "ea57e0f64785fcc90fe66f37358950318846ad24c2f34b55f0220721af264e8d"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.01.29-083204/wendy-cli-linux-static-musl-x86_64-2026.01.29-083204.tar.gz"
      sha256 "40347a22b84622d6f87c0df7e40acb40b487973016ce520ea6b4fc7deacdcb65"
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
