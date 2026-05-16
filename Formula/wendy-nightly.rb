class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.05.16-183003"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "f70483312175d60d1b5106270c2f10bf6671845a3dca7c6353f751f49cda223a"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.05.16-183003/wendy-cli-darwin-arm64-2026.05.16-183003.tar.gz"
    sha256 "05df8314ad605d4c508caade31777b552ac316f5f1d138133597a3fb375a3bbe"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.05.16-183003/wendy-cli-linux-arm64-2026.05.16-183003.tar.gz"
      sha256 "2dad6a3becee89088fd92e3418e237741cea980df57c53879321020946e554ab"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.05.16-183003/wendy-cli-linux-amd64-2026.05.16-183003.tar.gz"
      sha256 "697fc2b1233bf9b390ab3ad6bdfe9ec66cb393c86a0ff7076082b71c0a92ffd5"
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
