class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.06.11-072354"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "f98f9c8184b0ea679b77ddda373580c013d82e6314ea82de13ee029b5ad5905c"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.11-072354/wendy-cli-darwin-arm64-2026.06.11-072354.tar.gz"
    sha256 "e04fdd1dce3bbd90333b732f1c58c25f047445b681609f133ac99a4569ff8af3"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.11-072354/wendy-cli-linux-arm64-2026.06.11-072354.tar.gz"
      sha256 "adb439e96cf7bf5c7b0447233f56a71e92dede06d8f533655689394951bdf165"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.11-072354/wendy-cli-linux-amd64-2026.06.11-072354.tar.gz"
      sha256 "67f0fd5cb05abb66965b918d470a428d590684afd85b28b7e9d39b0d3b365d38"
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
