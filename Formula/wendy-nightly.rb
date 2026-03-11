class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.03.11-135134"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "ba7deffa697f8c84273563c531d2739496e166a0a74e27595e1046a1760d9fec"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.11-135134/wendy-cli-darwin-arm64-2026.03.11-135134.tar.gz"
    sha256 "a4adb6ab282ad6415afb0307dc54063705becfd96f4977f96e6ac4cdc1271a17"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.11-135134/wendy-cli-linux-arm64-2026.03.11-135134.tar.gz"
      sha256 "a35661484b18f47b1ab0f9749e88255fc5e5865abd880d12fd9d12b78be94650"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.11-135134/wendy-cli-linux-amd64-2026.03.11-135134.tar.gz"
      sha256 "c65e402d68c8b187a23503fec6ccb01959004ca7b1d2bb175f35a33b89dd40ff"
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
