class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.05.28-174222"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "3fafec7056cbfae0e26a0ea0dff27d50b02e97e9249ce349d01d9cb7786ccbe2"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.05.28-174222/wendy-cli-darwin-arm64-2026.05.28-174222.tar.gz"
    sha256 "2f6f346c52b215710bbf0d999c8394fa12ac9aa9a7ac3c9053202f7d2bf6d22c"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.05.28-174222/wendy-cli-linux-arm64-2026.05.28-174222.tar.gz"
      sha256 "ab2bc24157cab5c1c16ce2cd686e81593e8f9a777a30cfa5fb9b1cef75350437"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.05.28-174222/wendy-cli-linux-amd64-2026.05.28-174222.tar.gz"
      sha256 "dab16dbe1825661a081abf354f7dc30640db8cbcad5932f20cf9c84cddafa2d8"
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
