class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.06.27-090906"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "05d4cc112239fbebc04300b167683c68c3945bc2b33e4b48ba0b4e336034118b"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.27-090906/wendy-cli-darwin-arm64-2026.06.27-090906.tar.gz"
    sha256 "b7364c626667d9f1b9d42d30d500ac62ff86416a2aa0c353c2f312dae0b302bb"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.27-090906/wendy-cli-linux-arm64-2026.06.27-090906.tar.gz"
      sha256 "55b255aa7aec870db01d9542b66501f0a8cfc8f1bbfc848585f3ddbd67feb513"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.27-090906/wendy-cli-linux-amd64-2026.06.27-090906.tar.gz"
      sha256 "aeaa99bc5c339426096240141dcb4eb8bd4079a4cdfb57115e74f8c83e576597"
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
