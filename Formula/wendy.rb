class Wendy < Formula
  desc "CLI for building and running WendyOS applications"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-2026.03.12-171251"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "e7ff5b8cd8d0c35e2a835e9e52f23b5718938c5666de9e8873404aa2f74e0237"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.12-171251/wendy-cli-darwin-arm64-2026.03.12-171251.tar.gz"
    sha256 "5d93ca3f6b988ad38e28e08eada7a1498c68c71f7fa68c0da4c4c2d92667c0dd"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.12-171251/wendy-cli-linux-arm64-2026.03.12-171251.tar.gz"
      sha256 "61680a777a74ae2725894002bc0e64801699340caf156c3b03e9fe12fc02db25"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.12-171251/wendy-cli-linux-amd64-2026.03.12-171251.tar.gz"
      sha256 "ed2a13ab5d4a6cd3a0e1a0d40121ba4e964b4b90857b97d5c46b6b24a866d74a"
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
    assert_match "OVERVIEW: Wendy CLI", shell_output("#{bin}/wendy --help")
  end
end
