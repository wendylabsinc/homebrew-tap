class Wendy < Formula
  desc "CLI for building and running WendyOS applications"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-2026.01.29-171539"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "7e7a6bbb90e96c020e1653788b889c6896f8c2e9c4f5dcb3bb26b4818db4daab"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.01.29-231727/wendy-cli-macos-arm64-2026.01.29-231727.tar.gz"
    sha256 "15daadb5739f28d769fde77b52fa282322dcd3a452ed48c43fdd6ac17b723b41"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.01.29-231727/wendy-cli-linux-static-musl-aarch64-2026.01.29-231727.tar.gz"
      sha256 "07d5d106858c847dc93b25dc21e4ff41dfce7a1dbc2db2a8747e2425d19ac0e5"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.01.29-231727/wendy-cli-linux-static-musl-x86_64-2026.01.29-231727.tar.gz"
      sha256 "2e4e3b464f437553af6c5e7667b843073510a885a62d74743d1bc825ec614284"
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
