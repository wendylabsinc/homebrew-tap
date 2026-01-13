class Wendy < Formula
  desc "CLI for building and running WendyOS applications"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-2026.01.07-083101"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "7cb5f17869a46e1343bb684a83cc93dc889b7df1a57685899e080bbd13334f5f"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.01.07-083101/wendy-cli-macos-arm64-2026.01.07-083101.tar.gz"
    sha256 "60c781790e25c9bdf0c99bbe845fadef427d4cb2f83f02c4fe9544b93defd245"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.01.07-083101/wendy-cli-linux-static-musl-aarch64-2026.01.07-083101.tar.gz"
      sha256 "960f09698c521fa3c766476a5fcbf43aa03eea890d1d0bbf6483fe0e51c6db47"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.01.07-083101/wendy-cli-linux-static-musl-x86_64-2026.01.07-083101.tar.gz"
      sha256 "70ac4cc066cc2300439143df4617f548e177a615db20c7342aa59ec6f06a4ecc"
    end
  end

  def install
    # Install pre-built binaries (all platforms)
    bin.install "wendy"
    bin.install "wendy-helper" if File.exist?("wendy-helper")
    bin.install "wendy-network-daemon" if File.exist?("wendy-network-daemon")

    # Install macOS-specific bundle with resources (plist files, etc) if present
    bundle_path = "wendy-agent_wendy.bundle"
    (lib/"wendy").install bundle_path if File.directory?(bundle_path)
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
    assert_match "OVERVIEW: Wendy CLI", shell_output("#{bin}/wendy --help")
  end
end
