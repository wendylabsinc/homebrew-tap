class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.04.03-204558"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "6999b4e493692c33e8c5f271e7f08b2a0006602b86ae4a700f3a16f7dc49a01f"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.03-204558/wendy-cli-darwin-arm64-2026.04.03-204558.tar.gz"
    sha256 "1436853565bab65d2b0a7caf3d66b78751ea10897909b698194a2ccd5f0e3d31"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.03-204558/wendy-cli-linux-arm64-2026.04.03-204558.tar.gz"
      sha256 "64d4728b91bb6b53e6588b5be508c9de4de74eae42e00c8bf21654cbb245613f"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.03-204558/wendy-cli-linux-amd64-2026.04.03-204558.tar.gz"
      sha256 "ccc4c6ee0a6e503278a502f49770c18fc2b1f4ed8cad3db2baeb8b18e7a5954a"
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
