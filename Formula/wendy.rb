class Wendy < Formula
  desc "CLI for building and running WendyOS applications"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-2026.04.29-004102"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "6989a548992e00372b59d507e8eb17cd96ae1f93d72e7e41624d7b1f9aba9c0f"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.29-004102/wendy-cli-darwin-arm64-2026.04.29-004102.tar.gz"
    sha256 "ff6f67206f6743b4abb4f8a90583eb5b0cf408fca3ccb29dce0df04a3872ad8c"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.29-004102/wendy-cli-linux-arm64-2026.04.29-004102.tar.gz"
      sha256 "d7e68ea3c62b1af0e8e96c21a96668991dfb5e991c5e8a5eaa9465445bb383ee"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.29-004102/wendy-cli-linux-amd64-2026.04.29-004102.tar.gz"
      sha256 "c7aa7006f5a2c053181fc5a3b82c465debe87cc090701b57a206bbd52c0726b1"
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
