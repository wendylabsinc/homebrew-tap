class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.06.30-175529"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "5481d797d145fcce46b1b396ea786eb93fdb2397c471ccd5ed09399e2836b53e"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.30-175529/wendy-cli-darwin-arm64-2026.06.30-175529.tar.gz"
    sha256 "44dd7a3b354286f48c93d2ff5b99078817350ec92cdc1c8804296b31ff84689c"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.30-175529/wendy-cli-linux-arm64-2026.06.30-175529.tar.gz"
      sha256 "db2aa81dc7a07ec46dd43b85a0553269f3038928a8b0b85e2f5c7b3a350e541a"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.30-175529/wendy-cli-linux-amd64-2026.06.30-175529.tar.gz"
      sha256 "25c107c27617ab43dc565845e82f29ac014dc243821a70ab13e5a047675db4fc"
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
