class Wendy < Formula
  desc "CLI for building and running WendyOS applications"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-2025.12.08-155618"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "f4b6993bf1b1e076bc9384015d76d9984ec75e03bb9c4900de7fb3228ce4aa4f"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.12.08-203713/wendy-cli-macos-arm64-2025.12.08-203713.tar.gz"
    sha256 "7b0d384de778a6865feee1d0775d2cce229ffd593f14b934f3ec25d9f36938be"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.12.08-203713/wendy-cli-linux-static-musl-aarch64-2025.12.08-203713.tar.gz"
      sha256 "d5cf434bba4b1f22fa2b4f45fda8443a845b13f27063209b4a2f9a78abd4d3fa"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.12.08-203713/wendy-cli-linux-static-musl-x86_64-2025.12.08-203713.tar.gz"
      sha256 "b812d9e8c0ac371f6895d3721feb8d929a26191287293559313243afc61e908d"
    end
  end

  def install
    # Install pre-built binaries (all platforms)
    bin.install "wendy"
    bin.install "wendy-helper" if File.exist?("wendy-helper")
    bin.install "wendy-network-daemon" if File.exist?("wendy-network-daemon")

    # Install macOS-specific bundle with resources (plist files, etc) if present
    bundle_path = "wendy-agent_wendy.bundle"
    (lib/"wendy").install bundle_path if File.directory?(bundle_path)
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
