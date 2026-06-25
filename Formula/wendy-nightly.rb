class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.06.25-114850"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "db35e7edfeaea5caac48784c92ca4a9adb5dde9164d5a8e43767b6a2773aa821"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.25-114850/wendy-cli-darwin-arm64-2026.06.25-114850.tar.gz"
    sha256 "152a6b0fbca9c6d7144855b2c4e6e4888cb32f1975be7aa3419da73a386f1f23"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.25-114850/wendy-cli-linux-arm64-2026.06.25-114850.tar.gz"
      sha256 "03b64fc9ac2b919c36c03d147fb3b4d82a250561325e602acbdf5fe7aadd52d7"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.25-114850/wendy-cli-linux-amd64-2026.06.25-114850.tar.gz"
      sha256 "33623f77b19ae7308092a4a379af76f9f09f6829120cb87088b4cd1153fc0e09"
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
