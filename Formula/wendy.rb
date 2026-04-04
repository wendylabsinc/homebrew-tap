class Wendy < Formula
  desc "CLI for building and running WendyOS applications"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-2026.04.04-165600"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "20eada8e4caf99edaca0c7c24e467c1dbce061548dd1bf0e2e1f9f97c9dfa07c"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.04-165600/wendy-cli-darwin-arm64-2026.04.04-165600.tar.gz"
    sha256 "e8a9658e7edf7d7998dcef1e50d4eb39e78f5f1b1bbd6c15ab8b21d6cbc80c4b"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.04-165600/wendy-cli-linux-arm64-2026.04.04-165600.tar.gz"
      sha256 "470df32536321926b5f1cd1660d7392aaf245a84aab2b570664943f7cd75c8a0"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.04-165600/wendy-cli-linux-amd64-2026.04.04-165600.tar.gz"
      sha256 "f0f6e561544953fbf00ee14e4dcb24a6b7b8e00a48e3ff1e514a7f12873db54f"
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
