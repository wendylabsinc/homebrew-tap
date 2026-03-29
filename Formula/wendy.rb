class Wendy < Formula
  desc "CLI for building and running WendyOS applications"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-2026.03.29-173229"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "a6301104f572f5fa5ff13a8d3ce69c59da8b0152c6f63410b6750ceca0ff7278"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.29-173229/wendy-cli-darwin-arm64-2026.03.29-173229.tar.gz"
    sha256 "826069077e013c72c4ef8977ee2ab22d7e4253fb87c7e4038f93726882138037"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.29-173229/wendy-cli-linux-arm64-2026.03.29-173229.tar.gz"
      sha256 "46b3836272cbc8b5843ec591382f7ac378b679481ff2f939964b782e5641eee0"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.29-173229/wendy-cli-linux-amd64-2026.03.29-173229.tar.gz"
      sha256 "a5a5735fd384dd0bd39317ba929fdfd1f97f8e7700c11c6c0408171d989c7c7e"
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
