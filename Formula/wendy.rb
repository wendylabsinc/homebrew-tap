class Wendy < Formula
  desc "CLI for building and running WendyOS applications"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-2026.04.23-194832"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "8e5ee92002248877d7e76abe2b82f07e4a2e38001dcb22812c577c47d5858d2a"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.23-194832/wendy-cli-darwin-arm64-2026.04.23-194832.tar.gz"
    sha256 "c18ea3ec55084eb84ee722c3e8300dc211cd3471ce03192fbbd689d74191222c"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.23-194832/wendy-cli-linux-arm64-2026.04.23-194832.tar.gz"
      sha256 "2da4e1dd89cb19e68568ad681322ef3f19211e0b3b0f1d18e76f462aa12d1a71"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.23-194832/wendy-cli-linux-amd64-2026.04.23-194832.tar.gz"
      sha256 "5d0e60474b7ae2fe38bee5491aafc32584c1ff39dcbb81b896db461c1cec0133"
    end
  end

  conflicts_with "wendy-nightly", because: "both install a `wendy` binary"

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
    # TODO: It would be better to actually build something, instead of just checking the help text.
    system bin/"wendy", "--help"
    assert_match "wendy [command]", shell_output("#{bin}/wendy --help")
  end
end
