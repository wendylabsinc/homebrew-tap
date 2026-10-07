class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.10.07-071950"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "c340d518123061108a789f4dda6ebc33ab25ea66927d0488e4cd7dedfd805b8c"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.10.07-071950/wendy-cli-darwin-arm64-2026.10.07-071950.tar.gz"
    sha256 "7558c6350820698a5d86f3d5c68274dab36c089f6f557eb397c602c69ae97581"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.10.07-071950/wendy-cli-linux-arm64-2026.10.07-071950.tar.gz"
      sha256 "2d6f6880bc608c5c869cf2a24bbbb3250d67b2157f2856e54197cd9a706e5625"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.10.07-071950/wendy-cli-linux-amd64-2026.10.07-071950.tar.gz"
      sha256 "fe6b40ba8a70ebe2bc5f1dc6f171bd69a86a96605e41466343bae07a4e7f6860"
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
