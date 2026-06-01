class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.06.01-025237"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "0ce24165d45c74395162c6e1162bcfcdeadef77640bd7d280eb32d389e2f985e"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.01-025237/wendy-cli-darwin-arm64-2026.06.01-025237.tar.gz"
    sha256 "1b76eafc95ec59c27093c3f4a9da2752a0eb7f8c0c5beb93b6d9ce32f3711b9d"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.01-025237/wendy-cli-linux-arm64-2026.06.01-025237.tar.gz"
      sha256 "86de13e4032c9c9e91b11a8ae7fbe5ec5597dce427505d3adc2043cde96e5371"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.01-025237/wendy-cli-linux-amd64-2026.06.01-025237.tar.gz"
      sha256 "58cad20f5de9fab16716d89d053b06e03a01c90f47d95986b7558acf0ebc2dd9"
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
