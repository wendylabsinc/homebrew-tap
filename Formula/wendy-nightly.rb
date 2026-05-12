class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.05.12-094558"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "2cd01f5ab6c63380ae964160a3b744a3054a15fc9c68c3efe04ad9bf28019277"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.05.12-094558/wendy-cli-darwin-arm64-2026.05.12-094558.tar.gz"
    sha256 "68fe4297cbabcc9a626224e9bee1bf0771205cc862585f8d679e0c564f0c0052"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.05.12-094558/wendy-cli-linux-arm64-2026.05.12-094558.tar.gz"
      sha256 "ad7b2936c0c4f35593ad565bdab9b4386032174effc63eb0130404b6facf1960"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.05.12-094558/wendy-cli-linux-amd64-2026.05.12-094558.tar.gz"
      sha256 "8bb3e7f00aa4f2ac27e0a8e6916a371c60b30b5cec95249d4311ab0570b71799"
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
