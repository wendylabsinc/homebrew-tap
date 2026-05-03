class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.05.03-195540"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "377c2093a227fc386136f7a1541a4588ca2fa4dbf11035045db50201ab66ceed"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.05.03-195540/wendy-cli-darwin-arm64-2026.05.03-195540.tar.gz"
    sha256 "f0c38f2842633dd1a5539007122e4543f4c5e7f7e21b2e84fc3dec8b4130d1d1"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.05.03-195540/wendy-cli-linux-arm64-2026.05.03-195540.tar.gz"
      sha256 "0ea07653ab9bdced1368535220a2b7bfda164cff15c0150f3e5d6a48d95d9a35"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.05.03-195540/wendy-cli-linux-amd64-2026.05.03-195540.tar.gz"
      sha256 "5ae0eb04f7eb27bfb94ccf4e41d1d48617fa9e10d7118a6519eecd96d9442860"
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
