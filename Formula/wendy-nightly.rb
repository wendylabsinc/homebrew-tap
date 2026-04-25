class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.04.25-221645"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "e10a3249a6508e7fbea730c4e58877440c7cdf2d3749f23e8becb9d34508c2a6"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.25-221645/wendy-cli-darwin-arm64-2026.04.25-221645.tar.gz"
    sha256 "4fa788cb5700f0f25890b5f880f3f30c88753eff285e6aeb0eb0c98dfebec1c4"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.25-221645/wendy-cli-linux-arm64-2026.04.25-221645.tar.gz"
      sha256 "1b3b9be8db18bfa6d4eaf2ead95089df00d6dccab2a57ca3e693eedf08d31979"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.25-221645/wendy-cli-linux-amd64-2026.04.25-221645.tar.gz"
      sha256 "4e962fdfdaa358319e534cb21c0c1ca47ac1072524d470112abdf7e34a7c7f9c"
    end
  end

  conflicts_with "wendy", because: "both install a `wendy` binary"

  def install
    # Install pre-built binaries (all platforms)
    bin.install "wendy"
    bin.install "wendy-helper" if File.exist?("wendy-helper")
    bin.install "wendy-network-daemon" if File.exist?("wendy-network-daemon")

    # Install macOS-specific bundle with resources (plist files, etc) if present
    bundle_path = "wendy-agent_wendy.bundle"
    (lib/"wendy").install bundle_path if File.directory?(bundle_path)

    # Generate and install shell completions
    generate_completions_from_executable(bin/"wendy", "completion")
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
    system bin/"wendy", "--help"
    assert_match "OVERVIEW: Wendy CLI", shell_output("#{bin}/wendy --help")
  end
end
