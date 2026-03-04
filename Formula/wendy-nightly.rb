class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.03.04-010058"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "47f633eaa75df6df52e3f3bd663a9ed3205315ab323fb884ae0d295d4d2dae26"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.04-010058/wendy-cli-darwin-arm64-2026.03.04-010058.tar.gz"
    sha256 "e352392aa97d780c0ddec4e679f8f2281ac6c8f663df3dd5e17c4b2f3d196e69"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.04-010058/wendy-cli-linux-arm64-2026.03.04-010058.tar.gz"
      sha256 "bd2b713b5cf90544b0bd70f60453d4a22d451b3af11e4ae7528a252e42be3301"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.04-010058/wendy-cli-linux-amd64-2026.03.04-010058.tar.gz"
      sha256 "9a86a937a3ad1041bcd7f011841185e6689b2bab11b8f3002a5364dd5857b653"
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
