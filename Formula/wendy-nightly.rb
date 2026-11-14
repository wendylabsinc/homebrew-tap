class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.11.14-134017"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "9eaff61c41b6191d899b3c948741397a66f27fd47e7e1a9d95294937a9d5347b"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.11.14-134017/wendy-cli-darwin-arm64-2026.11.14-134017.tar.gz"
    sha256 "98b5a262c1bbcf0552ddb9cc53ddb49e24725ee7d6bebe9fdb8044672a041c20"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.11.14-134017/wendy-cli-linux-arm64-2026.11.14-134017.tar.gz"
      sha256 "c3796e0ca9125509c49f2b727116c466ad5c45626dbb34afcb88517fb0e8eea5"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.11.14-134017/wendy-cli-linux-amd64-2026.11.14-134017.tar.gz"
      sha256 "8d9e976253f8a0c1cca005f2e003d0ba88f520cedf96408e66c99c546caa570c"
    end
  end

  # Install local container runtimes separately so their setup cannot block Wendy.
  on_macos do
    # The macOS CLI links libusb dynamically (cgo/gousb) for Jetson flashing.
    depends_on "libusb"
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
        Apple `container` is installed separately and is only needed if you
        choose it for local Linux containers. It requires Apple Silicon and
        macOS Tahoe (26) or newer. To install, start, and verify it:
          #{Tty.bold.cyan}brew install container#{Tty.reset}
          #{Tty.bold.cyan}container system start --enable-kernel-install#{Tty.reset}
          #{Tty.bold.cyan}container run --rm alpine echo hello#{Tty.reset}
        To build images locally, also start the builder:
          #{Tty.bold.cyan}container builder start#{Tty.reset}
      EOS
    end

    s
  end

  test do
    system bin/"wendy", "--help"
    assert_match "wendy [command]", shell_output("#{bin}/wendy --help")
  end
end
