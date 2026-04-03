class Wendy < Formula
  desc "CLI for building and running WendyOS applications"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-2026.04.03-044617"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "097a6807d31c3f810b5022693d345bf1906e56830794484ec0aa330a27a994b3"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.03-044617/wendy-cli-darwin-arm64-2026.04.03-044617.tar.gz"
    sha256 "7ae8bd1092dc4b58a43b0c530a2fa453d48b55a07287cab8d3a36394fa4ba601"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.03-044617/wendy-cli-linux-arm64-2026.04.03-044617.tar.gz"
      sha256 "44b0e5e2cf1e3a822e308f7caaa362241818d9c307002abcdd2a64c7a419a05a"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.03-044617/wendy-cli-linux-amd64-2026.04.03-044617.tar.gz"
      sha256 "f238944df06c9003dfcb16f1ba8edbcbafa1d21dd23c2f20d82a407645e0378f"
    end
  end

  conflicts_with "wendy-nightly", because: "both install a `wendy` binary"

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
    # TODO: It would be better to actually build something, instead of just checking the help text.
    system bin/"wendy", "--help"
    assert_match "wendy [command]", shell_output("#{bin}/wendy --help")
  end
end
