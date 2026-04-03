class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.04.03-080020"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "60f85d1511b3b190faefb40739072325bc6f34f722c966542a0b565e444688e9"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.03-080020/wendy-cli-darwin-arm64-2026.04.03-080020.tar.gz"
    sha256 "10be639b42992d8c48b55d4ea2e47e9312fe2a6faf94f2a9e297796c61f41215"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.03-080020/wendy-cli-linux-arm64-2026.04.03-080020.tar.gz"
      sha256 "379b367b194577d2b2c456059f9d8d8e2bd4a13aa78898b635381eeee92df576"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.03-080020/wendy-cli-linux-amd64-2026.04.03-080020.tar.gz"
      sha256 "4f01ee735f841e1f10857fc665770bcd4fca33b48706feb038e876c713dbf048"
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
