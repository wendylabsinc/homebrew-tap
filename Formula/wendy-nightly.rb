class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.05.18-095503"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "bd317d3c8562de9b02ebb0d4be0f93aa4d109e4f40b72203aa48b529d1b45f38"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.05.18-095503/wendy-cli-darwin-arm64-2026.05.18-095503.tar.gz"
    sha256 "10c847bddc0129db449b58ad867478a41b7e65219054bb06fe07c95dd6765aff"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.05.18-095503/wendy-cli-linux-arm64-2026.05.18-095503.tar.gz"
      sha256 "d2ff6b95fe49c38a70e9c0714e44e84d8c0c35e673032bebee86bb7125b2e01a"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.05.18-095503/wendy-cli-linux-amd64-2026.05.18-095503.tar.gz"
      sha256 "479b53d29ba6c9b6ea22acdcc4132a0074c673d883fdd1e59e09b2a9bafb7098"
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
