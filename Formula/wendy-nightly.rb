class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.04.12-200821"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "30c34db906166663cedc9152a94d891fd16f067a6c48affafc98ddd4223db0eb"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.12-200821/wendy-cli-darwin-arm64-2026.04.12-200821.tar.gz"
    sha256 "27fe38faf088fdd89d8c5526a20be1ccf0075f759363ceb8cbe121bbe4a699e4"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.12-200821/wendy-cli-linux-arm64-2026.04.12-200821.tar.gz"
      sha256 "e6b4990a5f72f6bc871d11281d7b34ab5bcf250186f0dbc27ee762d76ace8aaa"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.12-200821/wendy-cli-linux-amd64-2026.04.12-200821.tar.gz"
      sha256 "2db7d2b1bbb8eccf45173a735dc7589b062914f1efe32ecd17c3fcc1e89f6590"
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
