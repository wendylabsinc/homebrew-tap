class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.11.02-233104"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "53ef5691629eb5b4f562155b47da9c709af3b6d81a03b99e491adb417e65c20a"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.11.02-233104/wendy-cli-darwin-arm64-2026.11.02-233104.tar.gz"
    sha256 "4e7639727f7df334dedaa848b3e73b47328afa1fa328a226a739835575a4216f"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.11.02-233104/wendy-cli-linux-arm64-2026.11.02-233104.tar.gz"
      sha256 "d74ce455a5d62215b71d62e38f4d4141c532e07a349e5fd89179d1f988c6fe42"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.11.02-233104/wendy-cli-linux-amd64-2026.11.02-233104.tar.gz"
      sha256 "18048d19432cb451621f97563df72ae0b09ce9c2ad629d029d1d6274e16dfd93"
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

  def caveats
    s = <<~EOS
      #{Tty.bold}Get started#{Tty.reset}
      To set up MCP integration with your AI tools:
        #{Tty.bold.cyan}wendy mcp setup#{Tty.reset}
      To start the interactive walkthrough:
        #{Tty.bold.cyan}wendy tour#{Tty.reset}

      #{Tty.bold}Anonymous analytics#{Tty.reset}
      Analytics are enabled by default to help improve commands and fix errors.
      To opt out, run:
        #{Tty.bold.cyan}wendy analytics disable#{Tty.reset}
      Or set the environment variable #{Tty.bold}WENDY_ANALYTICS=false#{Tty.reset}.
    EOS

    if OS.mac?
      s += <<~EOS

        #{Tty.bold}Local Linux containers#{Tty.reset}
        On macOS Tahoe (26) and newer, local Linux containers are powered by
        Apple `container`, installed by default with this formula there. Before
        first use, start its services once:
          #{Tty.bold.cyan}container system start#{Tty.reset}
          #{Tty.bold.cyan}container builder start#{Tty.reset}
        To skip installing it, reinstall with:
          #{Tty.bold.cyan}brew reinstall --without-container wendylabsinc/tap/wendy-nightly#{Tty.reset}
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
