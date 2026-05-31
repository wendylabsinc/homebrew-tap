class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.05.31-202736"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "1e8e16984dfd152de6f762d6ddf8fc503098e478e386e321c46a696b030e3bc3"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.05.31-202736/wendy-cli-darwin-arm64-2026.05.31-202736.tar.gz"
    sha256 "b4319cdf489a5cc8b2248452b0ddb604b46c655c705a4b9a6f11e3f73eae1db2"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.05.31-202736/wendy-cli-linux-arm64-2026.05.31-202736.tar.gz"
      sha256 "4375369e6fd7d5a493eee03aaaef7e256e4ca45294dbb2e90296f45b78dd7188"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.05.31-202736/wendy-cli-linux-amd64-2026.05.31-202736.tar.gz"
      sha256 "1e32ff73dc104d30610c2fddf87ac601b7ed848fa1e4151d339de33e1661f01b"
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
