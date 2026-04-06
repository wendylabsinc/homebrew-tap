class Wendy < Formula
  desc "CLI for building and running WendyOS applications"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-2026.04.06-194114"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "87f9a795a0eab47ce1979f1441e73418d03752e10cadd82fcb09b9c882b13d76"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.06-194114/wendy-cli-darwin-arm64-2026.04.06-194114.tar.gz"
    sha256 "71ee253c3587d40f5706e093ef25bf24abfb9c735d1175933067e3d3d99e6119"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.06-194114/wendy-cli-linux-arm64-2026.04.06-194114.tar.gz"
      sha256 "035a2e61dfcae7b2335f58363971a56c6442c7e3688e230a7605d2dbfd38a116"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.06-194114/wendy-cli-linux-amd64-2026.04.06-194114.tar.gz"
      sha256 "3b3fa9031ba0dbefaee1bc27446bcd888f877f735a81e36d953dad236f332c22"
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
