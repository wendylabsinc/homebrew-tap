class Wendy < Formula
  desc "CLI for building and running WendyOS applications"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-2025.12.08-063320"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "d53942f6a462212c19dc01a87a90c51d125d6e8d89b41f4d516b1555db5fdc19"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.12.08-155618/wendy-cli-macos-arm64-2025.12.08-155618.tar.gz"
    sha256 "b1e13112c270b5035b7f1d843a2a588afbd73f63dda7950668f5ededb669c289"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.12.08-155618/wendy-cli-linux-static-musl-aarch64-2025.12.08-155618.tar.gz"
      sha256 "71b7fb640b581e0708e1182f13fb37b29dc03ef48a4f0983ad2aa46d98c1c206"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.12.08-155618/wendy-cli-linux-static-musl-x86_64-2025.12.08-155618.tar.gz"
      sha256 "8607e4c4751dbcba81e82fa6a67f5dbb41e306a10aa756767789ff128784ad33"
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
