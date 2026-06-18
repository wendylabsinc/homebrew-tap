class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.06.18-193559"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "a006fd07375772927114a07eacdc0317fdbfbe8f23bc881b83e92c02d3e567b3"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.18-193559/wendy-cli-darwin-arm64-2026.06.18-193559.tar.gz"
    sha256 "eadc70c46355b5f7b1f385551050814515f7192cf6909d37e60e745c34f0f3b4"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.18-193559/wendy-cli-linux-arm64-2026.06.18-193559.tar.gz"
      sha256 "940ef043bf19c5640f6ab1c0911521013b0942a84a6c0667ad9d8fab6fe29e73"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.18-193559/wendy-cli-linux-amd64-2026.06.18-193559.tar.gz"
      sha256 "72e16e73de42a693440064053fff049a8be63ff9370bb67c9edacafa98d4c5b4"
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
