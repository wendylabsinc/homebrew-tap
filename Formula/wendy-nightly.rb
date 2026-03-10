class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.03.10-172754"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "06afb357a18ac2d73b55973cec0cc50d89e97488be30b022a232c50a5de88854"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.10-172754/wendy-cli-darwin-arm64-2026.03.10-172754.tar.gz"
    sha256 "71348f9e07fb24e3d8c06256fd50de3075c72c5a7ea83a629d53fe0c0d83a279"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.10-172754/wendy-cli-linux-arm64-2026.03.10-172754.tar.gz"
      sha256 "11d517b9e8ea74bed5cdc29e5ed8aaf7539ed334b95a474012400239d0580b99"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.10-172754/wendy-cli-linux-amd64-2026.03.10-172754.tar.gz"
      sha256 "3a0eb9035f2f83c6f8958e7d0eaaab56e49dd08f3618996ea85a9c72e10c3b00"
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
