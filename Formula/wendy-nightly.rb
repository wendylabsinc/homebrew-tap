class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.05.29-132910"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "ba7a7bf6acdbdc021450bbb2186bfc6398fe9ef200a30cd8e2b9a8b86d4226ca"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.05.29-132910/wendy-cli-darwin-arm64-2026.05.29-132910.tar.gz"
    sha256 "dcd3c76d32687d3843c49ad784b6727f626f600c864c4fea57eb5ec8bf0c0520"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.05.29-132910/wendy-cli-linux-arm64-2026.05.29-132910.tar.gz"
      sha256 "234adb50b39292fad486242099300f8e1a1ce90043aa6b04d0cd721185846c9a"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.05.29-132910/wendy-cli-linux-amd64-2026.05.29-132910.tar.gz"
      sha256 "9118b8d50acd9cf122a799123e758c0d9b9d486b7bfc581c3a7824ea758e20d3"
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
