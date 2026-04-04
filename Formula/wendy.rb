class Wendy < Formula
  desc "CLI for building and running WendyOS applications"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-2026.04.04-171216"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "b0a7dcacf49a426cf922b1abf896d377a615a1759777254ebd803265100cc0ec"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.04-171216/wendy-cli-darwin-arm64-2026.04.04-171216.tar.gz"
    sha256 "7db31846de9dc5551966ffc74e3430cb285b86e1e333d2ed42a0821a8290d40a"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.04-171216/wendy-cli-linux-arm64-2026.04.04-171216.tar.gz"
      sha256 "27dae4a9b491b8d7181892d3c005fbbc3386bb207269c6c0b41f1bcf2210a792"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.04-171216/wendy-cli-linux-amd64-2026.04.04-171216.tar.gz"
      sha256 "bd56e570c47dd0073d0aed6fb21aa9996066ceafa002024f4c827fdf531ca466"
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

  def caveats
    <<~EOS
      Attention: The Wendy CLI collects anonymous analytics.
      They help us understand which commands are used most, identify common errors, and prioritize improvements.
      Analytics are enabled by default. If you'd like to opt-out, use the following command:
        wendy analytics disable
      Or, set the following environment variable:
        WENDY_ANALYTICS=false
    EOS
  end

  test do
    # TODO: It would be better to actually build something, instead of just checking the help text.
    system bin/"wendy", "--help"
    assert_match "wendy [command]", shell_output("#{bin}/wendy --help")
  end
end
