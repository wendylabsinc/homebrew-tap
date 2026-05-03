class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.05.03-143941"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "b92b90d22e4d4576a05e1e716ff9ac6ccae5873135f877a111d08f227e2ab8f6"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.05.03-143941/wendy-cli-darwin-arm64-2026.05.03-143941.tar.gz"
    sha256 "2a33bfc48953ab5a9bbeb8c0878628697a16cb5d49b9ab21473f6d11d87c5e07"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.05.03-143941/wendy-cli-linux-arm64-2026.05.03-143941.tar.gz"
      sha256 "81b756e63d030f0cbf350153ac458f37f43e0b1bd63741f3478db8912f0b17da"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.05.03-143941/wendy-cli-linux-amd64-2026.05.03-143941.tar.gz"
      sha256 "aa553ba662fbf1c780b2c4347871d4a4887515000e5f36650b8269398a4f8aaa"
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
