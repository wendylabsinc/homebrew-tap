class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.03.16-201529"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "87edc654dde7b14809b1fbfed35a9d09575b17119d284df90ce7980183ec3423"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.16-201529/wendy-cli-darwin-arm64-2026.03.16-201529.tar.gz"
    sha256 "809dc05c3ccdd095bd86076b064c044d220a109ed29174a2dbe811c74427e2c5"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.16-201529/wendy-cli-linux-arm64-2026.03.16-201529.tar.gz"
      sha256 "c2d662ddafedeca8c5b87dd6f5db4b831452097fd214642921e9f0a41d55e0de"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.16-201529/wendy-cli-linux-amd64-2026.03.16-201529.tar.gz"
      sha256 "ad1459d6748d1709bcbae6d38238f5b505f0918c93f22c69abe393586a4a46e7"
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
