class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.03.16-151129"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "5e701693251c93c2ec7aaa5d03d591ff5be28775871d4765948a560e66ab11ea"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.16-151129/wendy-cli-darwin-arm64-2026.03.16-151129.tar.gz"
    sha256 "0d420c41be65cecd8f543d41d004d2840e2e6f694815afcd0eb10e6d60126f36"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.16-151129/wendy-cli-linux-arm64-2026.03.16-151129.tar.gz"
      sha256 "92c60a225a8aeaf3cf6c4acfbea29895c14793e7fcf729bd5687522409ed9dd3"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.16-151129/wendy-cli-linux-amd64-2026.03.16-151129.tar.gz"
      sha256 "7aecc21faf317ad45ba105e3b1e986b0116eabd5fcfaa60cf7172c1a6fbfe0a2"
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
