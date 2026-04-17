class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.04.17-143708"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "b4c07339da99fba5883d66b6f86d39bd9c434986aeb37605f94d927e7d8b6f60"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.17-143708/wendy-cli-darwin-arm64-2026.04.17-143708.tar.gz"
    sha256 "f12aece2c5f9ee89d7f6c205c98cc3a7463812fa0c015ed7e28ac793d4794448"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.17-143708/wendy-cli-linux-arm64-2026.04.17-143708.tar.gz"
      sha256 "e8a7528f686cba753086d5a15d88f351b6b087fd6ac0a01b93aac747285f65dd"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.17-143708/wendy-cli-linux-amd64-2026.04.17-143708.tar.gz"
      sha256 "d41adfd583ec45ff8c9047e5e4291fe622a731efeeedc9716067eb3ca2c0df1c"
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
