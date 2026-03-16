class Wendy < Formula
  desc "CLI for building and running WendyOS applications"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-2026.03.16-023243"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "fe1395395bf88ccd64c53d43f212a7dc1b760972a1001ec1d6edd7d848bdcc6a"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.16-023243/wendy-cli-darwin-arm64-2026.03.16-023243.tar.gz"
    sha256 "fe4e72b4c8825964f8488cba163f7d2c4d20ef73152637e3c741629b904e1159"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.16-023243/wendy-cli-linux-arm64-2026.03.16-023243.tar.gz"
      sha256 "c6fd26d294783f21070d26d27e9cde3dc67634e446734e5a7f081ba4e8ac1b75"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.16-023243/wendy-cli-linux-amd64-2026.03.16-023243.tar.gz"
      sha256 "496a5a9c2edad2b56c2f3af9d1391fcd4a06ee0ff64f2a98841efde9253d6c94"
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
