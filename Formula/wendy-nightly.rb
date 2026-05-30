class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.05.30-025900"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "a5245ea6da381549eada8997908171b55d5948ce604396904ee14099132f0e78"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.05.30-025900/wendy-cli-darwin-arm64-2026.05.30-025900.tar.gz"
    sha256 "7ffae7484c03f6c7472f8558f0526c0974bfacd6830abb23a3db52da48ab1fd4"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.05.30-025900/wendy-cli-linux-arm64-2026.05.30-025900.tar.gz"
      sha256 "7f8406aba769e9051da1eb19023902c656fdf57a6448a2c299cd393eacd8f9c8"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.05.30-025900/wendy-cli-linux-amd64-2026.05.30-025900.tar.gz"
      sha256 "f7b9ae94bd9b1a78f90439561d1ae24fb777f04e1ffcbb4b56644539dfcb7390"
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
