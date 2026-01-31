class Wendy < Formula
  desc "CLI for building and running WendyOS applications"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-2026.01.31-100512"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "2b17521bca31794b21da8bc266533c6074dbff7f718a58875662dfd6c6a5d587"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.01.31-100512/wendy-cli-macos-arm64-2026.01.31-100512.tar.gz"
    sha256 "3563eb52d698841a0a6ad332d2a28182082e916854abd3ae2f86553fb338023c"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.01.31-100512/wendy-cli-linux-static-musl-aarch64-2026.01.31-100512.tar.gz"
      sha256 "61f8fb3f3a5a0f34f3a046bcbd9a2b683e4a2f402eeb4a68356fe8e25348b533"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.01.31-100512/wendy-cli-linux-static-musl-x86_64-2026.01.31-100512.tar.gz"
      sha256 "8ec9b548b41c63f527c44a6e22bc9fed8a6c51e8877bf95456a69f4bb48adc4c"
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
