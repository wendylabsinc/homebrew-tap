class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.11.11-074823"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "383d8074f2b03df909c02a48b6354c8e70baa3674143e78d63aef99751b5d1e7"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.11.11-074823/wendy-cli-darwin-arm64-2026.11.11-074823.tar.gz"
    sha256 "cfea6f55a93f9b507f1d22283fc14fda5d056c4d673d6374c829f905b0304a3e"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.11.11-074823/wendy-cli-linux-arm64-2026.11.11-074823.tar.gz"
      sha256 "9039b654757e5663bc6fdb9d712b06c0c1e2141a4e5aa823e34cddb0c15fbc4e"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.11.11-074823/wendy-cli-linux-amd64-2026.11.11-074823.tar.gz"
      sha256 "11c15ecdf837b74d47154db77b24100529ad5ee86f56f86a3d130367699febc6"
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
