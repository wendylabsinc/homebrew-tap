class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.08.25-104401"
    rebuild 1
    sha256 cellar: :any, arm64_tahoe: "0c8d294569d2644f7aefb7f207808d57be9737630d8aee80b335adab9fd5c5fd"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.08.25-104401/wendy-cli-darwin-arm64-2026.08.25-104401.tar.gz"
    sha256 "c7a5ce7b99163f2e63f1b6e7dc10cd7fff35e10fd3f8b78ab2208bd0c6cd8251"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.08.25-104401/wendy-cli-linux-arm64-2026.08.25-104401.tar.gz"
      sha256 "deca08ab5e75c2c4fe14af7f8824e3e03c4b161a549d87954c732646b45ceb42"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.08.25-104401/wendy-cli-linux-amd64-2026.08.25-104401.tar.gz"
      sha256 "6e86204e1b1678d0302169642f71599a69e9fe29c23391668c4c0b3313fe4f13"
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
