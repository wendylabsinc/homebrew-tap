class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.05.04-111922"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "e79c6ad755427b10fa8a4be19f75776dd41f527c284bef8107be2ff26d1f4e71"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.05.04-111922/wendy-cli-darwin-arm64-2026.05.04-111922.tar.gz"
    sha256 "2df41a14f53d544c1f453aa1b8638e3da80d4c32f643c68cef460df5ea167d1b"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.05.04-111922/wendy-cli-linux-arm64-2026.05.04-111922.tar.gz"
      sha256 "50697277d59f9fdcecd3f57bcf4af5290cfe2ebb224860e4643f236c94a7cd4c"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.05.04-111922/wendy-cli-linux-amd64-2026.05.04-111922.tar.gz"
      sha256 "914d6af889bb03dbda4a7e5863e7b57edf381ee3c0dd908a65017b9707c5ccd1"
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
