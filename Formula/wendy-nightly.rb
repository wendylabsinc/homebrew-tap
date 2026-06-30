class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.06.30-075501"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "b51ab73fb884978c3e0e08217756b8dcd188429a79b0eec1da1e1a29b074d2bc"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.30-075501/wendy-cli-darwin-arm64-2026.06.30-075501.tar.gz"
    sha256 "b26876ca580269fdc5b8bb149557b5ba59c380e772cbb9b9bb68f297440d1442"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.30-075501/wendy-cli-linux-arm64-2026.06.30-075501.tar.gz"
      sha256 "ce08afb7a2bc0f518a9eb643386003d32c328168904b2c7de3344dc3e2b6dba8"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.30-075501/wendy-cli-linux-amd64-2026.06.30-075501.tar.gz"
      sha256 "485a2fee9ca4625c1f60d8f4bd2e9e6533f95f9e679d5319fedac36b99877322"
    end
  end

  # Apple `container` powers local Linux containers on macOS. Installed by
  # default; skip with `--without-container` if you only manage remote devices.
  on_macos do
    depends_on "container" => :recommended
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
    s = <<~EOS
      Attention: The Wendy CLI collects anonymous analytics.
      They help us understand which commands are used most, identify common errors, and prioritize improvements.
      Analytics are enabled by default. If you'd like to opt-out, use the following command:
        wendy analytics disable
      Or, set the following environment variable:
        WENDY_ANALYTICS=false

      To set up MCP integration with your AI tools:
        wendy mcp setup
    EOS

    if OS.mac?
      s += <<~EOS

        Local Linux containers on macOS are powered by Apple `container`
        (installed by default with this formula). Before first use, start its
        services once:
          container system start
          container builder start
        To skip installing it, reinstall with:
          brew install --without-container wendylabsinc/tap/wendy-nightly
      EOS
    end

    s
  end

  test do
    system bin/"wendy", "--help"
    assert_match "wendy [command]", shell_output("#{bin}/wendy --help")
  end
end
