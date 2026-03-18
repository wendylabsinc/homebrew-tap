class Wendy < Formula
  desc "CLI for building and running WendyOS applications"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-2026.03.18-202144"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "b8a144f707786501d1413d19e842ec5e47374e6b59d0ae02dcb7b9f9a322206d"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.18-202144/wendy-cli-darwin-arm64-2026.03.18-202144.tar.gz"
    sha256 "a106f6ed650dd3d1a9f8e2306e5a652751746203aed5dbcab969511e8c711764"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.18-202144/wendy-cli-linux-arm64-2026.03.18-202144.tar.gz"
      sha256 "70c2ef60a9910fd65eb2d575d0625521723256b765d39b359c07bb83cf2d8fd8"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.18-202144/wendy-cli-linux-amd64-2026.03.18-202144.tar.gz"
      sha256 "df1b95e5bede2311a2d86179a9d77748ff92a425671a2516bc66f31ebe611bd8"
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
