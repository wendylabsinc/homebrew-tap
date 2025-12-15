class Wendy < Formula
  desc "CLI for building and running WendyOS applications"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-2025.12.14-064816"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "34d1ba0f9673576ed05811a88ca84c92319b2b591f0a6ca56e9cb3ee7f5d921e"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.12.15-115115/wendy-cli-macos-arm64-2025.12.15-115115.tar.gz"
    sha256 "f0ab35a730173e0d38b30753ab163792e213480bafc1df739aab7d5abfb0a2a2"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.12.15-115115/wendy-cli-linux-static-musl-aarch64-2025.12.15-115115.tar.gz"
      sha256 "76bad00bb7cbbd1e1b33af819cf0bfd5e7d450f75ce3a0feaec9805d2b3b2643"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.12.15-115115/wendy-cli-linux-static-musl-x86_64-2025.12.15-115115.tar.gz"
      sha256 "f28331ae32e62f52cd9cba6481176a67c826aa4458e4569e7ce150cd2ea0190a"
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
