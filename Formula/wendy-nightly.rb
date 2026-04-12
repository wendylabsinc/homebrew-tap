class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.04.12-192309"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "21f283ed62463ec6b3969570ad34edbc354c96ac085befbccff5b5338a41c65a"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.12-192309/wendy-cli-darwin-arm64-2026.04.12-192309.tar.gz"
    sha256 "43d09492162286714a3fe11cff87a35d4cf8599278b8e0cf369e1def8179925d"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.12-192309/wendy-cli-linux-arm64-2026.04.12-192309.tar.gz"
      sha256 "ac86143ceb054000a69a37413e3d19105e1befcc462b2d56c6c016a1a30b7f0d"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.12-192309/wendy-cli-linux-amd64-2026.04.12-192309.tar.gz"
      sha256 "26dade5ef854abce40aac08329e569884292cf32d06134bf174e5cd8e61c407c"
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
