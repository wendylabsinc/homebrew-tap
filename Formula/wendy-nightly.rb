class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.03.03-223810"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "47f633eaa75df6df52e3f3bd663a9ed3205315ab323fb884ae0d295d4d2dae26"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.03-223810/wendy-cli-darwin-arm64-2026.03.03-223810.tar.gz"
    sha256 "6cc9f948a1c70993a64c5670a1c2375f82fc4c606574ed882afccfc8c415455c"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.03-223810/wendy-cli-linux-arm64-2026.03.03-223810.tar.gz"
      sha256 "c72915dca28d7b09df36c2eac5062f49879f2f68fab2af3b5d8141993d4fb4f0"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.03-223810/wendy-cli-linux-amd64-2026.03.03-223810.tar.gz"
      sha256 "c68fda4290212aca1dbd9c12be9f57e8f5e31ef8f6f21b5e132388f82e1c8780"
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
    generate_completions_from_executable(bin/"wendy", "--generate-completion-script")
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
