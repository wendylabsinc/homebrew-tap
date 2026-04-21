class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.04.21-161450"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "91c47c7bbadafd953b3411b2522bed74723440d5c277f09e128a33d1a763ada7"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.21-161450/wendy-cli-darwin-arm64-2026.04.21-161450.tar.gz"
    sha256 "1ea82ff751eba687d4c42bf41ca0c78c74e166fdaeab23fa129f7d9b7e710f89"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.21-161450/wendy-cli-linux-arm64-2026.04.21-161450.tar.gz"
      sha256 "cf0546e404a25a9300ba211c0dca023d4536fe2de41b53b6abe5525ce915092a"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.21-161450/wendy-cli-linux-amd64-2026.04.21-161450.tar.gz"
      sha256 "75d7ebb09f775f671d98cac4f1ce2438afbc62fb9f7ba5b76495aae409e5f390"
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
