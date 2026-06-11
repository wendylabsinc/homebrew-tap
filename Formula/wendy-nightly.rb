class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.06.11-062539"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "95518af14380eba59b3ef05f7984a3f31a2459aed34fa972d011832eebf75a47"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.11-062539/wendy-cli-darwin-arm64-2026.06.11-062539.tar.gz"
    sha256 "fcd5cd43f292055c070b74b17cb32b2dd12502b810d3dad0e86f20fddcb5dad3"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.11-062539/wendy-cli-linux-arm64-2026.06.11-062539.tar.gz"
      sha256 "b73c74f5e1fbb139ece139828c92fa216924010c6bf5927defcf8e4687e41f69"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.11-062539/wendy-cli-linux-amd64-2026.06.11-062539.tar.gz"
      sha256 "107ef09c056436c50d2b0be3f8e2cea6ece75524f30477ef3dd19b4a10f6ee0f"
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
