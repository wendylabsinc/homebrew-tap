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
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.12.08-200012/wendy-cli-macos-arm64-2025.12.08-200012.tar.gz"
    sha256 "2610699aa50b6da3051adf2e07d5eacffca0102399ef1cf0f9e65203e30974f7"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.12.08-200012/wendy-cli-linux-static-musl-aarch64-2025.12.08-200012.tar.gz"
      sha256 "cf2cc41fd0590affae6c6fc7098b3ea8deb03cc47c1a177e6387a34b1796733a"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.12.08-200012/wendy-cli-linux-static-musl-x86_64-2025.12.08-200012.tar.gz"
      sha256 "88c114757d7da1404602ed9dca47d4d70aa60a1b4667fbf8f88ef96772a9b05e"
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
