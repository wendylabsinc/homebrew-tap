class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.05.03-151137"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "b92b90d22e4d4576a05e1e716ff9ac6ccae5873135f877a111d08f227e2ab8f6"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.05.03-151137/wendy-cli-darwin-arm64-2026.05.03-151137.tar.gz"
    sha256 "ea6fecbf9e53d1e9af1e6e0abed2b5461f9a8485ce63f74193fadff0b0dfa2ed"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.05.03-151137/wendy-cli-linux-arm64-2026.05.03-151137.tar.gz"
      sha256 "a0c180dd4cae885b4b3e4a62e78fedceed44cf75472f98fe60f66a50a090e989"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.05.03-151137/wendy-cli-linux-amd64-2026.05.03-151137.tar.gz"
      sha256 "a998b0d524190a1490f6978ae1b64cedb5fe6d5097774d66fcff4ad0ead2fa52"
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
