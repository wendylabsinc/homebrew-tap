class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.06.27-181514"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "0ad70c3846caf345d2cd52f4baf926d7c77eb145c8ddfeea647e76a8abfc9d67"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.27-181514/wendy-cli-darwin-arm64-2026.06.27-181514.tar.gz"
    sha256 "410ac7887b047c896dbf6f33b4d9e066d96e5aeb4b4a1b6db1f7235d94be886d"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.27-181514/wendy-cli-linux-arm64-2026.06.27-181514.tar.gz"
      sha256 "cbf47c2f90df911fc121815e618236be5c0faa6d7ccc6b6dd6c311242ff562f4"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.27-181514/wendy-cli-linux-amd64-2026.06.27-181514.tar.gz"
      sha256 "a9fd1562c8be5cf914b8c5e587c249c4ff4c3dac69955ed0b1cfdff957810d11"
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
