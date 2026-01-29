class Wendy < Formula
  desc "CLI for building and running WendyOS applications"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-2026.01.29-085821"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "01a972095cfda3e0e3be4a0324e9b4d0b203f08a2c6fa68b173f66dbe1815f4c"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.01.29-085821/wendy-cli-macos-arm64-2026.01.29-085821.tar.gz"
    sha256 "04beee87398697ec8582ca9170122b37f29f33d092f6bf49f52d1b66a686047e"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.01.29-085821/wendy-cli-linux-static-musl-aarch64-2026.01.29-085821.tar.gz"
      sha256 "fa014609ff264418b13a59d677b961ba6a1bfb9a876066b262ce571931e7e6ec"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.01.29-085821/wendy-cli-linux-static-musl-x86_64-2026.01.29-085821.tar.gz"
      sha256 "4e545d5a23092a62029bc70d0fc325ee39a9cd7a55f581393b44d019c279522c"
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
