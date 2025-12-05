class Wendy < Formula
  desc "CLI for building and running WendyOS applications"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-2025.12.02-175042"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "6e7287ae288907e6bab5f8bcaa2020874eea35fc8c1f6fa62f0b80b7d27c557b"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.12.05-231206/wendy-cli-macos-arm64-2025.12.05-231206.tar.gz"
    sha256 "877982d7e65207a4c3a9b69127f645c0a9497c750f7d4f832b46f19f0cbd622b"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.12.05-231206/wendy-cli-linux-static-musl-aarch64-2025.12.05-231206.tar.gz"
      sha256 "5db7b47de6c3f8b390fce6e54a59786d9efc96b4c6a670b54311074541cd4385"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.12.05-231206/wendy-cli-linux-static-musl-x86_64-2025.12.05-231206.tar.gz"
      sha256 "474ae7261a79864f69ad6f30fc530df02a4b21b350c2dc99dc81bbbd7c41410c"
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
