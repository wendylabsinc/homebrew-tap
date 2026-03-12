class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.03.12-113313"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "f5eebc6e937917ca5a326c5c00f5edc6dc678ccb683f38bc89a154741c5e1558"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.12-113313/wendy-cli-darwin-arm64-2026.03.12-113313.tar.gz"
    sha256 "e3af9359f18ced0048feb554d1311209101bd3eb823ba1aeb3d48f27a0ee7023"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.12-113313/wendy-cli-linux-arm64-2026.03.12-113313.tar.gz"
      sha256 "28098db10f43931cf2ddb37d68883ab8afe70b17bd89bdd95aaa37d832a774f1"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.12-113313/wendy-cli-linux-amd64-2026.03.12-113313.tar.gz"
      sha256 "129955cc15b917e99a454eed6b0f83ae27d5618d76e434571ffe8fdd6a6a641d"
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
