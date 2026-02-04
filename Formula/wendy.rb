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
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.02.04-055115/wendy-cli-macos-arm64-2026.02.04-055115.tar.gz"
    sha256 "01b67f0de9935b5fe84018593037dee815f6417feb5553764b2b0f6eaf36e0d2"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.02.04-055115/wendy-cli-linux-static-musl-aarch64-2026.02.04-055115.tar.gz"
      sha256 "0a934c480e62c447b2818d9be9fb142450aa412e6f903febdd33b542ebd8c5c0"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.02.04-055115/wendy-cli-linux-static-musl-x86_64-2026.02.04-055115.tar.gz"
      sha256 "8932fb2b6e42efbac62506788d92b30cc46820c78a61570794916a72f6301416"
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
