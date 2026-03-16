class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.03.16-075904"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "03a7ca4c32bb0769aee8857454f26bf7e4747604d65fe8c1015ba580f157cca3"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.16-075904/wendy-cli-darwin-arm64-2026.03.16-075904.tar.gz"
    sha256 "4cd681240d76a59f287e2470b96c6b2e2507a0375cea56104561092abc0da199"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.16-075904/wendy-cli-linux-arm64-2026.03.16-075904.tar.gz"
      sha256 "7731a852e7fa4598e4c8d6b1de802190cdb5bcf8653a59d7ecbd859d0a5568da"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.16-075904/wendy-cli-linux-amd64-2026.03.16-075904.tar.gz"
      sha256 "d35cc01b11eea4a8ea8dabf1eafc283fba791040544371cf0a8557d3830fa36a"
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
