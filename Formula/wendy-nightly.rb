class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.05.15-191737"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "c3255ac71cc49fe9c268be4b0a820223bed3531dc0451cf148232d3da89011f8"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.05.15-191737/wendy-cli-darwin-arm64-2026.05.15-191737.tar.gz"
    sha256 "1736f9c2283f4b6d0cd77a90234ee147f684c7e397820adfb2d714c60bea4ed9"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.05.15-191737/wendy-cli-linux-arm64-2026.05.15-191737.tar.gz"
      sha256 "ba7b8fce67e11d34d135ec3faebd32ca95c5385b5a5014abc838f0f93cc97459"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.05.15-191737/wendy-cli-linux-amd64-2026.05.15-191737.tar.gz"
      sha256 "379a03d87da9998d900f7b0c49ffe1183e4f817b9d04da131efe6feeaff881bf"
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
