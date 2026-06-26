class Wendy < Formula
  desc "CLI for building and running WendyOS applications"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-2026.06.26-130116"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "0fb4a838280b643553dc79635b07c1060b83966789d87256c498cf799dabff6f"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.26-130116/wendy-cli-darwin-arm64-2026.06.26-130116.tar.gz"
    sha256 "64cafafcc137c0bb93429d5176257d86b79fbda866d2dea19e488eb651fded23"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.26-130116/wendy-cli-linux-arm64-2026.06.26-130116.tar.gz"
      sha256 "b0f5b1ea514e108c94b26f26e5cae74ab3926f680b559f9bb8bc897e96634ff8"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.26-130116/wendy-cli-linux-amd64-2026.06.26-130116.tar.gz"
      sha256 "4cfcfcbcebe48f05ed618af5665c86942528e7a257a703dde58e4b4480a32dad"
    end
  end

  conflicts_with "wendy-nightly", because: "both install a `wendy` binary"

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
    # TODO: It would be better to actually build something, instead of just checking the help text.
    system bin/"wendy", "--help"
    assert_match "wendy [command]", shell_output("#{bin}/wendy --help")
  end
end
