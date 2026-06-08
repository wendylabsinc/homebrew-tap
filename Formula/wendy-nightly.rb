class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.06.08-090718"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "d3adfc427729e9202d9f5eaabaaac1e7d3e7b37d36d6d89125435182fa65d411"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.08-090718/wendy-cli-darwin-arm64-2026.06.08-090718.tar.gz"
    sha256 "51e8773d1b9b32544afc63c513405b0f9add76352edd385f0602ae9ee0c3055c"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.08-090718/wendy-cli-linux-arm64-2026.06.08-090718.tar.gz"
      sha256 "a90cbc293bf6485ab425f8961a5a72b0bb00925456281e912e1e39df177e54e5"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.08-090718/wendy-cli-linux-amd64-2026.06.08-090718.tar.gz"
      sha256 "1c3fb4838704ecc5ba4a47524de1f6acd6ee7f4a15c1e222f41d2af83560beb0"
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
