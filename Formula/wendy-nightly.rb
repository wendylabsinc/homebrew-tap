class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.05.31-110207"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "461063aee6d8fc9dda7189673f36f8572d78182be8828cdfaddaca06cad9e6e7"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.05.31-110207/wendy-cli-darwin-arm64-2026.05.31-110207.tar.gz"
    sha256 "51c5bd9ae868ec7f97cd457432930cd25516ed9a8c26f405ac454a7508910447"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.05.31-110207/wendy-cli-linux-arm64-2026.05.31-110207.tar.gz"
      sha256 "1b83fbf815aced17a569532291f8574039a218477c55f9bad5239253e5b1284e"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.05.31-110207/wendy-cli-linux-amd64-2026.05.31-110207.tar.gz"
      sha256 "6f6d6d3630fb124589776bd02b461a49e460be1a838086e08fe070c53f5580e1"
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

  def post_install
    quiet_system bin/"wendy", "completion", "install"
  end

  def caveats
    <<~EOS
      Attention: The Wendy CLI collects anonymous analytics.
      They help us understand which commands are used most, identify common errors, and prioritize improvements.
      Analytics are enabled by default. If you'd like to opt-out, use the following command:
        wendy analytics disable
      Or, set the following environment variable:
        WENDY_ANALYTICS=false

      To set up MCP integration with your AI tools:
        wendy mcp setup
    EOS
  end

  test do
    system bin/"wendy", "--help"
    assert_match "wendy [command]", shell_output("#{bin}/wendy --help")
  end
end
