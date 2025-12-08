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
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.12.08-063320/wendy-cli-macos-arm64-2025.12.08-063320.tar.gz"
    sha256 "c9b8dc4611ed7060ee50cde85d3f13b2e71ba6e4978374ccabe1a8462d181624"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.12.08-063320/wendy-cli-linux-static-musl-aarch64-2025.12.08-063320.tar.gz"
      sha256 "0bde1b460edf68faff439a02c074f5a538426ff8e667ec0c9cc1941b14a8cda3"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.12.08-063320/wendy-cli-linux-static-musl-x86_64-2025.12.08-063320.tar.gz"
      sha256 "11db433fd000866afff074a3ba543903284a52b3c7732711515755f3fbf5bea1"
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
