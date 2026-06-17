class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.06.17-142611"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "ad4c1c295140af4e045f59eeed50059532339a226da9510977058d7251763402"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.17-142611/wendy-cli-darwin-arm64-2026.06.17-142611.tar.gz"
    sha256 "387494dbd1fb3752425ae7be4379956d8a8fdaed485e2ac6fed89a0c6010e3fa"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.17-142611/wendy-cli-linux-arm64-2026.06.17-142611.tar.gz"
      sha256 "073a780a652811fb0d4208a282326a9c6c731c2975fdbbc3bb89ed7ded6faf53"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.17-142611/wendy-cli-linux-amd64-2026.06.17-142611.tar.gz"
      sha256 "62931cc6de821d634a467e30dae2b90fbd6aa171bc33727f7a970485cdd2baa1"
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
