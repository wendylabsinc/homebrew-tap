class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.06.30-214908"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "3fe5f20f36ff3aefb8e6925f7a36f097fd2ffcdcd2ddfeea4238843b9dc652ba"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.30-214908/wendy-cli-darwin-arm64-2026.06.30-214908.tar.gz"
    sha256 "846f8a4b4598e88278b54ae9dbe9acf7cbb7f754ddcaa8d902ce27fdc6971567"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.30-214908/wendy-cli-linux-arm64-2026.06.30-214908.tar.gz"
      sha256 "7e4296e8bae0d2888680361ad2385f903d615e5156fa7d39619fc254be195f71"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.30-214908/wendy-cli-linux-amd64-2026.06.30-214908.tar.gz"
      sha256 "89ac2db5d39a4a0c1f10e68cebb02e164b63b63e1310909f3520401cfb3e5d43"
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
