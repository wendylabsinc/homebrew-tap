class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.06.19-121323"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "1b7a2886d6b0c44b09b898a1f1bbcbf9777926870a01e6010187f2a28f11c674"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.19-121323/wendy-cli-darwin-arm64-2026.06.19-121323.tar.gz"
    sha256 "34dbc7b2c1e49e11724280ae2dad8632d3dce68160f3abad2f6794c1861010c6"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.19-121323/wendy-cli-linux-arm64-2026.06.19-121323.tar.gz"
      sha256 "4b29a88354721f2a4c13bc5f4d14f45ae55c13558877ad7d580ffdb9f2a9ecc2"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.19-121323/wendy-cli-linux-amd64-2026.06.19-121323.tar.gz"
      sha256 "bf02d350e4cae1fd9b2812b8e5adcf065fee100eb0efac210837908f70469577"
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
