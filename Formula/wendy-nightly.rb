class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.05.29-213935"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "caa469676dcaa7050e735897b360ba7e19804ef61ee3238b0f5da32935aae9d3"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.05.29-213935/wendy-cli-darwin-arm64-2026.05.29-213935.tar.gz"
    sha256 "fc1f6b2781eef097b1857a65c7a1612e4f4975094563251f3a53d8a9c1ae0ca6"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.05.29-213935/wendy-cli-linux-arm64-2026.05.29-213935.tar.gz"
      sha256 "9c98e5340aa9069e01fe363f026820262b08bf069836c04efd155b2223528122"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.05.29-213935/wendy-cli-linux-amd64-2026.05.29-213935.tar.gz"
      sha256 "e7be3e7d7c4fd1f3e9992f13b5342ca603fe2b0f76c681fdf066bc550c9bdc63"
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
