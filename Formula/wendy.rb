class Wendy < Formula
  desc "CLI for building and running WendyOS applications"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-2026.02.02-093032"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "47f633eaa75df6df52e3f3bd663a9ed3205315ab323fb884ae0d295d4d2dae26"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.02.03-164821/wendy-cli-macos-arm64-2026.02.03-164821.tar.gz"
    sha256 "08e6305a031f052026ce08dc0c0927f7a78a5e8d651f58235d8c58840f0b5ee4"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.02.03-164821/wendy-cli-linux-static-musl-aarch64-2026.02.03-164821.tar.gz"
      sha256 "047ae116c2ddd0471775202e858b35ef855320b26950e0152565e927d9c55c90"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.02.03-164821/wendy-cli-linux-static-musl-x86_64-2026.02.03-164821.tar.gz"
      sha256 "16823ee2c34b274fe4561088e3e0b0a4ede2d8e0315d66779e98116f22f747b2"
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
