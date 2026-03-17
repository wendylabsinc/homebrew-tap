class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.03.17-230906"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "b626e0b544ff1ab89ce65803a488d9fec825c76d51c6de27686bed6e7e57129a"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.17-230906/wendy-cli-darwin-arm64-2026.03.17-230906.tar.gz"
    sha256 "694a01f79aa0676e9ef94403cd3a3f4128f78d2ea0cbd86faf3be86cf9271c08"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.17-230906/wendy-cli-linux-arm64-2026.03.17-230906.tar.gz"
      sha256 "29c24daf3a2825b5fbccf00116d8aac5be51290b4567d2b611de2d7b5970f4bd"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.17-230906/wendy-cli-linux-amd64-2026.03.17-230906.tar.gz"
      sha256 "de273aab9cb2b13858e09809b43f654d288319691427e13aba6884febbcb735e"
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
