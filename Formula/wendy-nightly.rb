class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.03.19-165455"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "1000c0fc75486216e28a6628983e361692d2eec930fdaf8b34fdd3aea3d3c7c5"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.19-165455/wendy-cli-darwin-arm64-2026.03.19-165455.tar.gz"
    sha256 "9376cae318c8a4e3131effd93df850766192b133fbc092657a46fe76eec2b08c"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.19-165455/wendy-cli-linux-arm64-2026.03.19-165455.tar.gz"
      sha256 "8b534505b6eabb17062441797de55163c76f84a7107120f6b5999dfc2a27b31e"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.19-165455/wendy-cli-linux-amd64-2026.03.19-165455.tar.gz"
      sha256 "5d980a803bbd1970feb1fa4d847758050af3a156dda26b5b11805bcf8fb988bb"
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
