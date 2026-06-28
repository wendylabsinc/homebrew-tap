class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.06.28-191102"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "e900e9c1760c09c08def67288b9228e42a69cede3a311d104f0fa5b3d5968d23"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.28-191102/wendy-cli-darwin-arm64-2026.06.28-191102.tar.gz"
    sha256 "66a8e90bf67f379dd140960439ddd1f656bedf682d88e53923a28662e8e7a8a3"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.28-191102/wendy-cli-linux-arm64-2026.06.28-191102.tar.gz"
      sha256 "b881c101893eecac0f0bd37b63f088b35b782ea573fb0936c96359375d20f149"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.28-191102/wendy-cli-linux-amd64-2026.06.28-191102.tar.gz"
      sha256 "77e7c03698e8c5d98f89d0f4435a6fd3eb4fd498f346180bfada22b38962be15"
    end
  end

  # Apple `container` powers local Linux containers on macOS. Installed by
  # default; skip with `--without-container` if you only manage remote devices.
  on_macos do
    depends_on "container" => :recommended
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

        Local Linux containers on macOS are powered by Apple `container`
        (installed by default with this formula). Before first use, start its
        services once:
          container system start
          container builder start
        To skip installing it, reinstall with:
          brew install --without-container wendylabsinc/tap/wendy-nightly
      EOS
    end

    s
  end

  test do
    system bin/"wendy", "--help"
    assert_match "wendy [command]", shell_output("#{bin}/wendy --help")
  end
end
