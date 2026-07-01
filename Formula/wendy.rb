class Wendy < Formula
  desc "CLI for building and running WendyOS applications"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-2026.07.01-101829"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "13a5e42376a608b7aeb6dbdc1f321913d9dfb3c36a8fc9f68fc7dbc77a3eed3a"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.07.01-101829/wendy-cli-darwin-arm64-2026.07.01-101829.tar.gz"
    sha256 "45cbb69bb6c7c1670d04cfbc7f3ce160c47862bca2d3cad044d55e9e97b2233c"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.07.01-101829/wendy-cli-linux-arm64-2026.07.01-101829.tar.gz"
      sha256 "92dab59e9d64c4545be376e26e65a6780a6971dd5991a795cf83852bc23edfe0"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.07.01-101829/wendy-cli-linux-amd64-2026.07.01-101829.tar.gz"
      sha256 "8fdb94374db86d265a9dbecb33de0f4c0ec94469aed92e3a3d96ecdd35127303"
    end
  end

  # Apple `container` powers local Linux containers on macOS. Installed by
  # default; skip with `--without-container` if you only manage remote devices.
  on_macos do
    depends_on "container" => :recommended
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
          brew install --without-container wendylabsinc/tap/wendy
      EOS
    end

    s
  end

  test do
    # TODO: It would be better to actually build something, instead of just checking the help text.
    system bin/"wendy", "--help"
    assert_match "wendy [command]", shell_output("#{bin}/wendy --help")
  end
end
