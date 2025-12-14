class Wendy < Formula
  desc "CLI for building and running WendyOS applications"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-2025.12.12-181444"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "a2df49e7118b812a6588414340b7e2077c9af47028886d011b7d7f734a238d9a"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.12.14-064816/wendy-cli-macos-arm64-2025.12.14-064816.tar.gz"
    sha256 "cc7054d5bb99d5ebf70fa989d45266b7065c092c7fbaa5a8f805e9f40dad88dc"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.12.14-064816/wendy-cli-linux-static-musl-aarch64-2025.12.14-064816.tar.gz"
      sha256 "e453a531207268519b76806982c282c902a899734f3f67fa82060efbe0db2aa1"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.12.14-064816/wendy-cli-linux-static-musl-x86_64-2025.12.14-064816.tar.gz"
      sha256 "89ae796f72502de24db376eefaa807b17a5ce7e5242336a5c6a1ecb9618e9281"
    end
  end

  def install
    # Install pre-built binaries (all platforms)
    bin.install "wendy"
    bin.install "wendy-helper" if File.exist?("wendy-helper")
    bin.install "wendy-network-daemon" if File.exist?("wendy-network-daemon")

    # Install macOS-specific bundle with resources (plist files, etc) if present
    bundle_path = "wendy-agent_wendy.bundle"
    (lib/"wendy").install bundle_path if File.directory?(bundle_path)
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
    assert_match "OVERVIEW: Wendy CLI", shell_output("#{bin}/wendy --help")
  end
end
