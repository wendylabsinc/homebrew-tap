class Wendy < Formula
  desc "CLI for building and running WendyOS applications"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-2025.12.30-104150"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "ccf133cd4d5276f01de69554ac40106006e769f81c16f99924ee9fad6f630e67"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.01.01-164324/wendy-cli-macos-arm64-2026.01.01-164324.tar.gz"
    sha256 "8d82ebd9de5763752ae606917fd21bd4642af033cf3f5bd9ac95df55d446fc09"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.01.01-164324/wendy-cli-linux-static-musl-aarch64-2026.01.01-164324.tar.gz"
      sha256 "6ff252e8f3e8ba34db476a4653576cb18ea0c283e5e1afdfb0bfb0ddb7db98d4"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.01.01-164324/wendy-cli-linux-static-musl-x86_64-2026.01.01-164324.tar.gz"
      sha256 "b3a954ab3a4301ac27fa74eb68e2cd8264d8c83b2285b1ee4eb1d4e2dfc148d0"
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
