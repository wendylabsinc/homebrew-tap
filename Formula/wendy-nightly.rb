class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.04.17-233212"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "ec7e5a43efca62627c7ada29d67dae5f613cb9917b91f4387e6973616043c06f"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.17-233212/wendy-cli-darwin-arm64-2026.04.17-233212.tar.gz"
    sha256 "d64ee26032d0ebc8d6c13bd77fc4aca126d204ed54bdb9dc1745ea7893359311"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.17-233212/wendy-cli-linux-arm64-2026.04.17-233212.tar.gz"
      sha256 "dfa046fa9722e8b3c5ae2f99c323eef25e8a8018b08a8e1cfcbefe893a88f06b"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.17-233212/wendy-cli-linux-amd64-2026.04.17-233212.tar.gz"
      sha256 "ba022ae4acc7497573b2763a41d8e4305677c4f3e33dab596c968e938068fa43"
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
