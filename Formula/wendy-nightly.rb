class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.03.24-082348"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "2357968645f999b25cf41bd4d838ef8bb1f0d07a3e3ca88d3979a1b4bd35cc9f"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.24-082348/wendy-cli-darwin-arm64-2026.03.24-082348.tar.gz"
    sha256 "6556cd9e0d11a99bebb5d49e73088a5feb950fe5691534e2ddbd722b5811d17b"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.24-082348/wendy-cli-linux-arm64-2026.03.24-082348.tar.gz"
      sha256 "6b5e69bb69d473ac6599db7135410186cd67b0678d1478c123dc9c071a26cb69"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.24-082348/wendy-cli-linux-amd64-2026.03.24-082348.tar.gz"
      sha256 "1e85bedb346672aba051e522aedc35ce7174db790d2415dc2825fa0eea11dd7d"
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
