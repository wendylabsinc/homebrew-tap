class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.05.01-195936"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "ed3e971a0fae49b9790b0ef9a46e26cb767a4910d234d3542aefdd4e7a1d9a13"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.05.01-195936/wendy-cli-darwin-arm64-2026.05.01-195936.tar.gz"
    sha256 "84646306b7082c7876221eae9969db15ce8c597cbde2aa3c36a9b5a37ebe4994"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.05.01-195936/wendy-cli-linux-arm64-2026.05.01-195936.tar.gz"
      sha256 "a92344c31c6a58d61fa542aaa8db75db8005732b9c9c4fc4e2dd81d03f6cc2ae"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.05.01-195936/wendy-cli-linux-amd64-2026.05.01-195936.tar.gz"
      sha256 "15a6a61b1b1ef9954d0e4162785793ff3832b376bf735a241aa4c372e9b3195b"
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
