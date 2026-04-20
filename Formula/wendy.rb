class Wendy < Formula
  desc "CLI for building and running WendyOS applications"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-2026.04.20-234857"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "8e5ee92002248877d7e76abe2b82f07e4a2e38001dcb22812c577c47d5858d2a"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.20-234857/wendy-cli-darwin-arm64-2026.04.20-234857.tar.gz"
    sha256 "26f5e8d28de9d16c5b7196dbc7148c64734c39de3828985e2eb44bccdb827609"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.20-234857/wendy-cli-linux-arm64-2026.04.20-234857.tar.gz"
      sha256 "31f7da004859e64967e06dc543bc623d956516320c5949fc6716bd57438e88bf"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.20-234857/wendy-cli-linux-amd64-2026.04.20-234857.tar.gz"
      sha256 "fbca4dcbf7dca6a83fab0a1fa55a7cb5f502961fa4679494db977225ff19adb8"
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
