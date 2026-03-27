class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.03.27-073026"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "6d34eaacc304d78dc907dde38b94ceac4245c1e879141ed40d84465aa5f1c4cd"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.27-073026/wendy-cli-darwin-arm64-2026.03.27-073026.tar.gz"
    sha256 "a4bd1627a46703a230a4be4a2a2d4c992c94bacb3fce66e2637f40cb25385865"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.27-073026/wendy-cli-linux-arm64-2026.03.27-073026.tar.gz"
      sha256 "2a8e34313523e1d8fd661f88740b485b69437ccd95ff5d59273ac25a8535994a"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.27-073026/wendy-cli-linux-amd64-2026.03.27-073026.tar.gz"
      sha256 "28d0139d71da1a8934aa0ad3f01ff909a3b5519cf3930420c5ca68ab3a87b918"
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
