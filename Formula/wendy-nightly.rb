class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.04.03-080505"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "f59d28bfcda9cdf9c780b1bb54c199da6adb364bc03444d6ca4127d18732d88a"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.03-080505/wendy-cli-darwin-arm64-2026.04.03-080505.tar.gz"
    sha256 "d92d1ca3444622273fc11e9c9c1dfdf6b779243493c500f3d181539713a73fe0"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.03-080505/wendy-cli-linux-arm64-2026.04.03-080505.tar.gz"
      sha256 "3d690098533f34d3368f158eba9fd9626e3e1e3259ff28ad9add84ce9d4b5107"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.03-080505/wendy-cli-linux-amd64-2026.04.03-080505.tar.gz"
      sha256 "cbd10f84b69f05db45b19b869a408b6f45c44e3db0664c08e235bc3aa0d9500e"
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
