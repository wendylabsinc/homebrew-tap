class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.04.17-111958"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "4d774be4045b05c74fc05721b4bc5bbd9beb5c8eb600f3d127c51018fc07f5a4"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.17-111958/wendy-cli-darwin-arm64-2026.04.17-111958.tar.gz"
    sha256 "36a1d9b9dbb5469ed65a8915f3e630ed0972d9cfe516e8b5071d9550f64c65b9"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.17-111958/wendy-cli-linux-arm64-2026.04.17-111958.tar.gz"
      sha256 "aa7106f8b61251cabf0be701c67db2719ddc61536dd3e86d7b25d4b0e91ff989"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.17-111958/wendy-cli-linux-amd64-2026.04.17-111958.tar.gz"
      sha256 "3b7652d799aa40754ae06037342d72410ac9819fd3c851d397122f130cb92b56"
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
