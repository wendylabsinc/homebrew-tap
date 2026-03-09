class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.03.09-155946"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "bf75e1053bba4d038bc8154a6c2ea5df7984e0e9c76e47209b787186b0def774"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.09-155946/wendy-cli-darwin-arm64-2026.03.09-155946.tar.gz"
    sha256 "960aced4c5cf4450a15400685138c533df44ac28228170f9913c2e9fc958c638"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.09-155946/wendy-cli-linux-arm64-2026.03.09-155946.tar.gz"
      sha256 "d1d8f68762f08f3042537ce8356cd99e76d336aa1d945507b14d273cfb4bbc2b"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.09-155946/wendy-cli-linux-amd64-2026.03.09-155946.tar.gz"
      sha256 "b37994dc1a2558c47ac3340383605f7293ff608dde2461aa12ffdaa35b2a7ca0"
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
