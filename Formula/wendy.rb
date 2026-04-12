class Wendy < Formula
  desc "CLI for building and running WendyOS applications"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-2026.04.12-201325"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "7c73d61121350ab8756174618e19f2250d61f4802503645eae75e8384a48df09"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.12-201325/wendy-cli-darwin-arm64-2026.04.12-201325.tar.gz"
    sha256 "239463bafe4d81eaa7622a9fefcc96726b1cac1a4a0fb7818afd0872dc289004"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.12-201325/wendy-cli-linux-arm64-2026.04.12-201325.tar.gz"
      sha256 "21d565cb662f6751e0fd2c79403a61276c891498c6d0bc95c2554e9b71f2971e"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.12-201325/wendy-cli-linux-amd64-2026.04.12-201325.tar.gz"
      sha256 "1f20b65408edbf15f637c1b90b6bd371f94aad96c7f387791592e28ae062a6a6"
    end
  end

  conflicts_with "wendy-nightly", because: "both install a `wendy` binary"

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
    # TODO: It would be better to actually build something, instead of just checking the help text.
    system bin/"wendy", "--help"
    assert_match "wendy [command]", shell_output("#{bin}/wendy --help")
  end
end
