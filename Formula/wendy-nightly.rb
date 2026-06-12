class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.06.12-090136"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "3c8ebdbe5fd215d006a4130b28528dc2c58a0c9e792ee0ff6741827444bf43a6"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.12-090136/wendy-cli-darwin-arm64-2026.06.12-090136.tar.gz"
    sha256 "b5c75fbf3757bea7288c2079c43dc832033511eef4b3797a8eed8fbaafe82c92"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.12-090136/wendy-cli-linux-arm64-2026.06.12-090136.tar.gz"
      sha256 "3c48fc71a3e5290eb8a467ed5b869e95d504c99d64702d55ca8cae26aba8c347"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.12-090136/wendy-cli-linux-amd64-2026.06.12-090136.tar.gz"
      sha256 "22a9a565e3e548e366934518a2b00efb6d75d990ef6115fd407e5232884a619a"
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
