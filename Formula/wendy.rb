class Wendy < Formula
  desc "CLI for building and running WendyOS applications"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-2026.01.27-103450"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "c882ba2ebbe7fbca62bace0c4ca20b94be1b226d7092e12ad234e7792cdf3d00"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.01.27-103450/wendy-cli-macos-arm64-2026.01.27-103450.tar.gz"
    sha256 "e5e63293070aac400e95062f389bfe3e4dced8658dd21e29c920f50bcc25e754"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.01.27-103450/wendy-cli-linux-static-musl-aarch64-2026.01.27-103450.tar.gz"
      sha256 "f43a34ac6fa289568009c8a42800ba3db65bd31585ed3aa191815c77c8a256fb"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.01.27-103450/wendy-cli-linux-static-musl-x86_64-2026.01.27-103450.tar.gz"
      sha256 "3bc64029f78b7aa1be3be8677758ca0df479b73c65a1a581e87352a079695493"
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
