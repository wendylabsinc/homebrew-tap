class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.05.17-191501"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "72401762f8b11f6e800b7dee72eaa5caf0706be380a711d9638eca8cf4215ee5"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.05.17-191501/wendy-cli-darwin-arm64-2026.05.17-191501.tar.gz"
    sha256 "64cd2736d7019dadc5feccfce2d8aba479de6227783670b78257a0cade7eb705"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.05.17-191501/wendy-cli-linux-arm64-2026.05.17-191501.tar.gz"
      sha256 "7f4b6787931c283617f16a550c5298ecad451e3f7601c84a8132c3fe7f32f81f"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.05.17-191501/wendy-cli-linux-amd64-2026.05.17-191501.tar.gz"
      sha256 "dc809bb7269eeff8d0e7379ff4f096e7c372b6675469d52429fc59523a28f93b"
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
    assert_match "OVERVIEW: Wendy CLI", shell_output("#{bin}/wendy --help")
  end
end
