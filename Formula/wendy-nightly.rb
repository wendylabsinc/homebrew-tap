class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.06.15-234103"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "e5e12f81bb5b455badce413862045b8f2600a6fae518ce9e3d078b40c89e5be2"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.15-234103/wendy-cli-darwin-arm64-2026.06.15-234103.tar.gz"
    sha256 "ea180b8a1d5a497d95b9d005ad248c3c39ddc13ee9486ca869f9014e8868773c"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.15-234103/wendy-cli-linux-arm64-2026.06.15-234103.tar.gz"
      sha256 "05d0b37de15e0a8e0aa51ba5cf27031c168f661cd276d8d46ca2349628aa72b2"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.15-234103/wendy-cli-linux-amd64-2026.06.15-234103.tar.gz"
      sha256 "f3dce2b181a64c10dee0cbc3d232cd6f039da5c81b79d2fbeef7bbc86c67f6be"
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
