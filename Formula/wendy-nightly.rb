class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.03.15-163335"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "3702ee93d9465ed506e3caa29ea537b820f7ebebb69fde77a36bc98e33d158fe"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.15-163335/wendy-cli-darwin-arm64-2026.03.15-163335.tar.gz"
    sha256 "83373ef7aac834d242b036bd4c8256883fc64f6561f2eb91eff823d9f3df68b8"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.15-163335/wendy-cli-linux-arm64-2026.03.15-163335.tar.gz"
      sha256 "1bad29276117cdaea65340e0eb4547fa78cb1049bcb75aca137eae781cbfed13"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.15-163335/wendy-cli-linux-amd64-2026.03.15-163335.tar.gz"
      sha256 "a3dfcd140b73f34e17aecb67529f21bf3043dfc63c1250bb2cfe4f851f73946d"
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
