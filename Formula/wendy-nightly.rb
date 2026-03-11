class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.03.11-100346"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "cf97ff6e406c0d8ea4f5f88be4e6823844240b7a93c1d6c137d9c72915c02ec3"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.11-100346/wendy-cli-darwin-arm64-2026.03.11-100346.tar.gz"
    sha256 "ede8b7c5ee5a39b2d9be51ce9b178f9efeb9ba2623052daa17d6579941e641f8"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.11-100346/wendy-cli-linux-arm64-2026.03.11-100346.tar.gz"
      sha256 "cce82da97a1c71c6d9cc51b9d568cd63a4fdb69854c933e7e4348f57d4f5d5ea"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.11-100346/wendy-cli-linux-amd64-2026.03.11-100346.tar.gz"
      sha256 "75bac3ab766886e02faccd6f69dc8d625a5d53ff27deccd96fbeabbab4a93591"
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
