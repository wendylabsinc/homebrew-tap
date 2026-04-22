class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.04.22-002842"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "970182fb959302c2d816d424a5f9c40bac655eca3e1ca315fe0e8bca0ef802c0"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.22-002842/wendy-cli-darwin-arm64-2026.04.22-002842.tar.gz"
    sha256 "62e3469df277de80840be96c70ebfff5126b7edf1e06ce551d4b70edd2384c3a"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.22-002842/wendy-cli-linux-arm64-2026.04.22-002842.tar.gz"
      sha256 "3eb7492742edbd78600e8b84e448a0088d9e30e69af9c0861ae897d40114c9cd"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.22-002842/wendy-cli-linux-amd64-2026.04.22-002842.tar.gz"
      sha256 "dbaf504fc9e82891266936bb4a0f394ce1ff37dfdb988f18188588036c5c1d5d"
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
