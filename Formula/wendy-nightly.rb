class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.04.17-083300"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "1276e51cec095faaf8f7d118311e248d5e17dd773239df5bfadff4074e301f3b"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.17-083300/wendy-cli-darwin-arm64-2026.04.17-083300.tar.gz"
    sha256 "14eccfc5106eb89c961c9ed2555d6718a2b76dfbd4d7645581055009cf92c45f"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.17-083300/wendy-cli-linux-arm64-2026.04.17-083300.tar.gz"
      sha256 "5648cc38398a5a5b37f7e7a61fc03d13b30bdde7760953cd22007383537f0c0e"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.17-083300/wendy-cli-linux-amd64-2026.04.17-083300.tar.gz"
      sha256 "41c9657aa5c62f10ac6cce21d1aec5dc0ad4699a7e0b69b6bba476642bce6a2f"
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
