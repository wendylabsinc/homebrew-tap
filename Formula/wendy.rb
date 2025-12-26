class Wendy < Formula
  desc "CLI for building and running WendyOS applications"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-2025.12.21-091451"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "0987650f119d81ea6f131116f65d0571d71d374c2d1d5a5d75fe6e8eb9ab8f83"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.12.26-211420/wendy-cli-macos-arm64-2025.12.26-211420.tar.gz"
    sha256 "5107ea9b15d894ca2a6a612d97cc6fc5733c8ccafedefcd15c6d341876408e02"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.12.26-211420/wendy-cli-linux-static-musl-aarch64-2025.12.26-211420.tar.gz"
      sha256 "8c9dceee0da107a89747863f3c37bba29b941eadf35665401199e470eb344d20"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.12.26-211420/wendy-cli-linux-static-musl-x86_64-2025.12.26-211420.tar.gz"
      sha256 "6d60f3910e8926590e53edaae4affef28ce9486a67ee1a8b65ea41d390c15052"
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
