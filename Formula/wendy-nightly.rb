class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.03.16-145735"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "5e701693251c93c2ec7aaa5d03d591ff5be28775871d4765948a560e66ab11ea"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.16-145735/wendy-cli-darwin-arm64-2026.03.16-145735.tar.gz"
    sha256 "914b94e22467ceb52bc8c3d09677c7e2881c74c57502583d7dcd8fe7f6658568"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.16-145735/wendy-cli-linux-arm64-2026.03.16-145735.tar.gz"
      sha256 "2c225ab47e5a38a5604b72dda579c8526b13b9042455c153b7f6238972821954"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.16-145735/wendy-cli-linux-amd64-2026.03.16-145735.tar.gz"
      sha256 "e1aebd7168c08106e89e97602c0f9df1ab22ecad6eb6dfce03f9851e942c008f"
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
