class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.11.08-224654"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "8ab34ebbf3ba43f8d66e243aa1986f5eadfd3f8f2681b5bc50070f6819dce19f"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.11.08-224654/wendy-cli-darwin-arm64-2026.11.08-224654.tar.gz"
    sha256 "561f289c5d040a3ba9755d22260f3aa82bfdc4d2927d7f441b48319be401314d"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.11.08-224654/wendy-cli-linux-arm64-2026.11.08-224654.tar.gz"
      sha256 "02e1c716c2aeac9386ee99a7b7b629ca74abe2a1948fb4c1e2cdcea1d21d4f5a"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.11.08-224654/wendy-cli-linux-amd64-2026.11.08-224654.tar.gz"
      sha256 "4b4a86a208f0ce8e27e56860e8404e37f6a25d835e8690fd8a42ff37304cebb7"
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
