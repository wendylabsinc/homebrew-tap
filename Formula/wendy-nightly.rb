class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.09.19-173329"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "36b5cf300dbcc186b4addb22c14b79e92e5126f56052f1e226044eec9a7487f5"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.09.19-173329/wendy-cli-darwin-arm64-2026.09.19-173329.tar.gz"
    sha256 "93b8fe835fbe00f09cdfcbb9f4037c50c32b5845ce10b7cc7c2e47a84c87c166"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.09.19-173329/wendy-cli-linux-arm64-2026.09.19-173329.tar.gz"
      sha256 "2a64e539ad884c63f4a3c1b761b6d5aaf4678b01270d1ce763da8e6f32822bb0"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.09.19-173329/wendy-cli-linux-amd64-2026.09.19-173329.tar.gz"
      sha256 "1e2cde6233e00f67590888da133285a6a03316d00af5df4c237985229506a4de"
    end
  end

  # Apple `container` powers local Linux containers on macOS. Installed by
  # default; skip with `--without-container` if you only manage remote devices.
  on_macos do
    # The macOS CLI links libusb dynamically (cgo/gousb) for Jetson flashing.
    depends_on "libusb"

    # Apple `container` only ships bottles for macOS Tahoe (26) and newer.
    # Gate the dependency on that — otherwise `brew install wendy-nightly`
    # aborts on older macOS with "container: no bottle available!" (a Tier 3
    # config), even though the pre-built wendy binary itself runs fine. wendy
    # works without `container` via Docker or for remote-only device management.
    on_tahoe :or_newer do
      depends_on "container" => :recommended
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

  post_install_steps do
    run "wendy", args: ["completion", "install"], base: :bin, must_succeed: false, print_stderr: false
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

        On macOS Tahoe (26) and newer, local Linux containers are powered by
        Apple `container`, installed by default with this formula there. Before
        first use, start its services once:
          container system start
          container builder start
        To skip installing it, reinstall with:
          brew install --without-container wendylabsinc/tap/wendy-nightly
        (`container` has no bottle on older macOS, so it is not installed there.)
      EOS
    end

    s
  end

  test do
    system bin/"wendy", "--help"
    assert_match "wendy [command]", shell_output("#{bin}/wendy --help")
  end
end
