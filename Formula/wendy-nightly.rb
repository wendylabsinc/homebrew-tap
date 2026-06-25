class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.06.25-201650"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "a1530e22cdf08d1b21cb4a660efef24d67dea60c1a27be7983804e775f9d57dc"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.25-201650/wendy-cli-darwin-arm64-2026.06.25-201650.tar.gz"
    sha256 "614f0305c0cb6139d186bca4677fd9d257ca97c0eec6401d184b7dd4452d73f7"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.25-201650/wendy-cli-linux-arm64-2026.06.25-201650.tar.gz"
      sha256 "922b535bf8718055f77429163b54b432f5251138e19b8575d76dde6344b3a799"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.25-201650/wendy-cli-linux-amd64-2026.06.25-201650.tar.gz"
      sha256 "facce21775d512e28a6d9ceacc61a07a033a727cc6281be4b5318dc9e57f2903"
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
