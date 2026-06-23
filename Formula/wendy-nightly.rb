class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.06.23-111829"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "6c810919c0aca5d9222c2d049ca58776ebc2b6e785d04c7888bab5dfa4c7410e"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.23-111829/wendy-cli-darwin-arm64-2026.06.23-111829.tar.gz"
    sha256 "3fdccf9e210aca4a2e1cdeb37b2fa61fde6fc2d186fb61ecaed777b9dacf96bd"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.23-111829/wendy-cli-linux-arm64-2026.06.23-111829.tar.gz"
      sha256 "b62cb8fd66a8ec9ad0224acd30647a060143228dabbd71aa26d75dfbdbd3286d"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.23-111829/wendy-cli-linux-amd64-2026.06.23-111829.tar.gz"
      sha256 "b6d99acb4e31249d0c58a8366fcea10b7a13a02e5d610a374fca47ca53329d7a"
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
