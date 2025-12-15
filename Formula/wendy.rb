class Wendy < Formula
  desc "CLI for building and running WendyOS applications"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-2025.12.15-115115"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "c8b161cbe9d506ba412cc9a7cdb0799c6bdc08adef165c001cc49757da8bd045"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.12.15-133022/wendy-cli-macos-arm64-2025.12.15-133022.tar.gz"
    sha256 "fe458dc342f9cf3198cb6e05ee617b425d4cb7f7040c90a513adf681cac09e94"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.12.15-133022/wendy-cli-linux-static-musl-aarch64-2025.12.15-133022.tar.gz"
      sha256 "8aae402559657a308062eeab6affbf463e53a5f427cd1de6fbca4c8a7cffc036"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.12.15-133022/wendy-cli-linux-static-musl-x86_64-2025.12.15-133022.tar.gz"
      sha256 "e85327c1c5c97c8dba0b65d88e9224961266120704627db915f3fa4fdcec7db5"
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
