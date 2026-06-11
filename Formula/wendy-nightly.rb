class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.06.11-070111"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "9c6895f4fe3a893a47ba69f157b5b0fe7c894e1d3327178a60515d23ce3b54bf"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.11-070111/wendy-cli-darwin-arm64-2026.06.11-070111.tar.gz"
    sha256 "647628b7414c510a3f57e64628409da65fcb6120e0d826fc4b4e66bd631afc51"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.11-070111/wendy-cli-linux-arm64-2026.06.11-070111.tar.gz"
      sha256 "88b9e20fb3abf188bec5f397f81e1c2d45682373184158b1497c7901de8a538f"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.11-070111/wendy-cli-linux-amd64-2026.06.11-070111.tar.gz"
      sha256 "5cdff7f9aa51cbd73f5794163b2dcc21d7b5389974bd640e8d5aa25fdc7c4421"
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
