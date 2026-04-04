class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.04.04-075649"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "88ead90c32d02fecbcbb0315d7574efec31732c8297b2e852f8ffb822628bdbe"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.04-075649/wendy-cli-darwin-arm64-2026.04.04-075649.tar.gz"
    sha256 "d8e1215200a2fb4dde79967c9d05b379916f6a95d93fad7ec5777f948c33db85"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.04-075649/wendy-cli-linux-arm64-2026.04.04-075649.tar.gz"
      sha256 "f9c71375c7ea006b6ef937ec94eddbcc708989305070a0e1d783ba48f8a8bd4a"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.04-075649/wendy-cli-linux-amd64-2026.04.04-075649.tar.gz"
      sha256 "db6a020956904a4dc31d9ea4ec9181dc5ff72a2be78f62fff85ea11603b2b6af"
    end
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
    system bin/"wendy", "--help"
    assert_match "OVERVIEW: Wendy CLI", shell_output("#{bin}/wendy --help")
  end
end
