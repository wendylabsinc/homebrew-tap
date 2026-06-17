class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.06.17-140825"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "9e2fa0781949a34c085a80864d94acc7639e89a2d11f93406c6604cdabb78220"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.17-140825/wendy-cli-darwin-arm64-2026.06.17-140825.tar.gz"
    sha256 "bfeb7df8860963a590e4a1d5e35d86ce5d9b8be45bd6f87c8bedef7e23e471b5"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.17-140825/wendy-cli-linux-arm64-2026.06.17-140825.tar.gz"
      sha256 "da580eebc54705fa56e4dd7e82caefb87c65d015b55f0f89c4850aee209db47f"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.17-140825/wendy-cli-linux-amd64-2026.06.17-140825.tar.gz"
      sha256 "92462b1c38e70d583f7cb5293d48056c45a191e9a646f7ad76e00b752774bb0c"
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
