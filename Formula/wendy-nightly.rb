class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.06.19-113242"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "7c4985c33be8dbdc347cd8d859044e34eab4d9862b53bf7d7523fb7538c34d1a"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.19-113242/wendy-cli-darwin-arm64-2026.06.19-113242.tar.gz"
    sha256 "b174ace0ceef16493c2434967dfed2e51117eef72a5c3775e8802cca3a90b7d4"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.19-113242/wendy-cli-linux-arm64-2026.06.19-113242.tar.gz"
      sha256 "d9853cfb585fb7b69347ef0329a44246790b66d2438b7e81d88e9e063883f713"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.19-113242/wendy-cli-linux-amd64-2026.06.19-113242.tar.gz"
      sha256 "d02ad8922049a1227cc5c48708b791e4ce5b6cdfa3247873c6ae1e3662d8b5ef"
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
