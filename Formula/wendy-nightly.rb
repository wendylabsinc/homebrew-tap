class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.04.05-110137"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "344c4ce465f4451f8e080ffbaaa72ddbdacd6295a00e12fce499fe2333f085cb"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.05-110137/wendy-cli-darwin-arm64-2026.04.05-110137.tar.gz"
    sha256 "eabfbbff12fc7ad90e30b297a9a34fefcc132a121cd6ecc213185e9577e0e794"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.05-110137/wendy-cli-linux-arm64-2026.04.05-110137.tar.gz"
      sha256 "ace378ef8b93f61935dd0a94e245eb8d619f7a5dbda04acdc714d793ee09d550"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.05-110137/wendy-cli-linux-amd64-2026.04.05-110137.tar.gz"
      sha256 "dee7a65dc26afb32308e1c65f93105167c4cf5534c6926b1d8bb751872df359c"
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
