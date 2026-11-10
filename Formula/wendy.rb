class Wendy < Formula
  desc "CLI for building and running WendyOS applications"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-2026.11.10-171611"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "32e0fb04aa52b550a2c1af31214652a1df40db0c9dbf001a6827ab3a02a31bc4"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.11.10-171611/wendy-cli-darwin-arm64-2026.11.10-171611.tar.gz"
    sha256 "3118b7d26f95eedf597134caea49926cc4760e20a4d61780c25c4e5fc43beed8"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.11.10-171611/wendy-cli-linux-arm64-2026.11.10-171611.tar.gz"
      sha256 "6753f82ab6e8623b40da95f71d9b1779372ce8dc206389b4f66a6f66fd945567"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.11.10-171611/wendy-cli-linux-amd64-2026.11.10-171611.tar.gz"
      sha256 "691243d37ce8e73d985451a2bf2e74380bc19b57719f55f67032b6608dd3e9a9"
    end
  end

  # Install local container runtimes separately so their setup cannot block Wendy.
  on_macos do
    # The macOS CLI links libusb dynamically (cgo/gousb) for Jetson flashing.
    depends_on "libusb"
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
    # TODO: It would be better to actually build something, instead of just checking the help text.
    system bin/"wendy", "--help"
    assert_match "wendy [command]", shell_output("#{bin}/wendy --help")
  end
end
