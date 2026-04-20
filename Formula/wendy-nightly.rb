class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.04.20-224954"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "cae012b17b06980c117bcd68eb1054e36ee2922b162201be5ba2ca3b72c23928"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.20-224954/wendy-cli-darwin-arm64-2026.04.20-224954.tar.gz"
    sha256 "a2337308deb05cd5a02344ca126a5c5531eec02ca3e3d0df23f5f245c2c9c6f1"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.20-224954/wendy-cli-linux-arm64-2026.04.20-224954.tar.gz"
      sha256 "dcafa9c6f9030be0c4c5fcb9de40f0e8a77637b724a850885a93b74e67adb2ca"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.20-224954/wendy-cli-linux-amd64-2026.04.20-224954.tar.gz"
      sha256 "ad520268cfe084599d959771f6e8098439a7bc0d4ae715fd59fb93459b75d8fe"
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
