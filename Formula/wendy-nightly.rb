class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.03.09-102025"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "0ee358d917109e4f7a678bebaa60f012b4b2a5a24599037ec96c762412e38c7c"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.09-102025/wendy-cli-darwin-arm64-2026.03.09-102025.tar.gz"
    sha256 "914c4f9184441ae7c35bf0b3ceccc1ed5df64a9e77fe1587ba5d8c8d45982282"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.09-102025/wendy-cli-linux-arm64-2026.03.09-102025.tar.gz"
      sha256 "753d3613a9f2807c289c91128902d6b8e0370c7e54e55d4975a26ab3aff78f81"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.09-102025/wendy-cli-linux-amd64-2026.03.09-102025.tar.gz"
      sha256 "3d1a0ef8de5ea6e269cfc73a7dbfead72f6ca8e0c5a1215b8941560f60828f31"
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
