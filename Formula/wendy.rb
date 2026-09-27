class Wendy < Formula
  desc "CLI for building and running WendyOS applications"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-2026.09.27-215032"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "75f6249ed2ceb0d23859c07ee3e4a5c2917c489e1c33cfd4ea5f4fdb4edcf8d6"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.09.27-215032/wendy-cli-darwin-arm64-2026.09.27-215032.tar.gz"
    sha256 "8159e783c940743aefc6152def3330ea628ff2b1802df783e9fe882486a9ce69"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.09.27-215032/wendy-cli-linux-arm64-2026.09.27-215032.tar.gz"
      sha256 "2fbc9151391cadc8eacc1d5befeb88ea71925cd72fba102d26220ecc00502789"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.09.27-215032/wendy-cli-linux-amd64-2026.09.27-215032.tar.gz"
      sha256 "58c0e4fc39ea691ed906c7df176f2568ba3a77bbc7155d746efa5610f27d8a2b"
    end
  end

  # Apple `container` powers local Linux containers on macOS. Installed by
  # default; skip with `--without-container` if you only manage remote devices.
  on_macos do
    # The macOS CLI links libusb dynamically (cgo/gousb) for Jetson flashing.
    depends_on "libusb"

    # Apple `container` only ships bottles for macOS Tahoe (26) and newer.
    # Gate the dependency on that — otherwise `brew install wendy` aborts on
    # older macOS with "container: no bottle available!" (a Tier 3 config),
    # even though the pre-built wendy binary itself runs fine. wendy works
    # without `container` via Docker or for remote-only device management.
    on_tahoe :or_newer do
      depends_on "container" => :recommended
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
          brew install --without-container wendylabsinc/tap/wendy
        (`container` has no bottle on older macOS, so it is not installed there.)
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
