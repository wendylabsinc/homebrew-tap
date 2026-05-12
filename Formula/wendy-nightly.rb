class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.05.12-153510"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "85ae8df28162510a58b454f202a9d0cb7376b4dfd4e156fd7199709ad3f62446"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.05.12-153510/wendy-cli-darwin-arm64-2026.05.12-153510.tar.gz"
    sha256 "366cd0c5db013fc3ec0968c00b636061e10b9dd8ec54730992ad96b1b555aa15"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.05.12-153510/wendy-cli-linux-arm64-2026.05.12-153510.tar.gz"
      sha256 "3aa91983889b081f3edf04b3ad977fcdcce17c993959fd00ee1a9e8416ebf1fe"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.05.12-153510/wendy-cli-linux-amd64-2026.05.12-153510.tar.gz"
      sha256 "1d8164bd8e7840b6f93b97c485eb063f216c37339d2516d1af920354a3727ab7"
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
