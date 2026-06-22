class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.06.22-091911"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "97a9e9ed2cbf859cd1e06db6cff47064a036ad3575729c0125a8855a60a0e2f9"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.22-091911/wendy-cli-darwin-arm64-2026.06.22-091911.tar.gz"
    sha256 "94f3492ae8f0e42b7f9ed0d9b9043bf2ac26ace3409e2c86188f66e5f57d3251"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.22-091911/wendy-cli-linux-arm64-2026.06.22-091911.tar.gz"
      sha256 "3676e4dc2861b5d451bc75334166bdfae437d1d699d2e0365e0316a2b382dee7"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.22-091911/wendy-cli-linux-amd64-2026.06.22-091911.tar.gz"
      sha256 "94afe6c6df74b7c1a35b36b3d47889e2b9ebfb8b4ded4a6985e75165bbf761a2"
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
