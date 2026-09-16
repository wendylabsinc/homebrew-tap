class Wendy < Formula
  desc "CLI for building and running WendyOS applications"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-2026.09.16-025644"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "66758bf1742cc6e4a4a99432640057cd2e6eeb918deffc0252376159bfbf8433"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.09.16-025644/wendy-cli-darwin-arm64-2026.09.16-025644.tar.gz"
    sha256 "5932f9b9645f16c512b781ec990d36bfc4233b0ecef1b325f904938acae739e0"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.09.16-025644/wendy-cli-linux-arm64-2026.09.16-025644.tar.gz"
      sha256 "421572cb4a0f9bb473c9cf31286b18855cbf5e3ef31e0a4c41685ded10ca9afd"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.09.16-025644/wendy-cli-linux-amd64-2026.09.16-025644.tar.gz"
      sha256 "bc22d72c124128976938e6d21e9133db99fe56e527317d7bcc8b4fcf1a1a2e2b"
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
