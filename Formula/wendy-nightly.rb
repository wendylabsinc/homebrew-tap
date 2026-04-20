class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.04.20-113309"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "afd59d7f25753a458d4be2b853acf2d3624925bebcf22be7a5292a64a608ac82"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.20-113309/wendy-cli-darwin-arm64-2026.04.20-113309.tar.gz"
    sha256 "960c48e5c04ddabc393d691889d022ce23765f0f056a75c4fc3ab330c62f50c3"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.20-113309/wendy-cli-linux-arm64-2026.04.20-113309.tar.gz"
      sha256 "0410ed747783854f7ea7161620e7ed43401f8561fc5f9130fa342327c9f2419b"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.20-113309/wendy-cli-linux-amd64-2026.04.20-113309.tar.gz"
      sha256 "99f6c2bdcc48a63c84df74b1de1445cd1927480d1d789a5c149ee9d412da4a14"
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
