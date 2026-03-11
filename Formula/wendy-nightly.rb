class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.03.11-144804"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "f903bd2fa2aff35483c726a4cd79c077321e0b23c3d7a72c36fed8b30235ebbc"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.11-144804/wendy-cli-darwin-arm64-2026.03.11-144804.tar.gz"
    sha256 "9f7923eaacc82e5daa91625d50bc2a64fb76b91e1f6778544114763bb73e6d7d"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.11-144804/wendy-cli-linux-arm64-2026.03.11-144804.tar.gz"
      sha256 "a4cd79660cf7f298daac8dce1e41fb00e501b43adf09177688debcf91d40e19c"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.11-144804/wendy-cli-linux-amd64-2026.03.11-144804.tar.gz"
      sha256 "23e26832cd864ba2fca6d4eef379931385cc87b410f538991734af720c27e765"
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
