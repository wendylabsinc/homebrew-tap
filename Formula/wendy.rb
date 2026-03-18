class Wendy < Formula
  desc "CLI for building and running WendyOS applications"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-2026.03.18-192427"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "c001c14ccc02e24ce4c921bd1173dd4b7a9c6d227ccf9246a77235d7fbe47404"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.18-192427/wendy-cli-darwin-arm64-2026.03.18-192427.tar.gz"
    sha256 "09d280e3d4969f72728afaba85f5a88c7ccdd3343c9268f9881227d4d0a23f66"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.18-192427/wendy-cli-linux-arm64-2026.03.18-192427.tar.gz"
      sha256 "6f8ba0505ac77e181d156136d3f514f3236fb6b40ab72f721f46c3192242dd72"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.18-192427/wendy-cli-linux-amd64-2026.03.18-192427.tar.gz"
      sha256 "1a894dc50ee1b2c863b3379d9492c62a889952af1f6a2e61f2d0334fd64e05be"
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
