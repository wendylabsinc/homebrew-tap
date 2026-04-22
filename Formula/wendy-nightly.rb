class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.04.22-110444"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "bba9282ea6609544747d22050d02cea919d10d44210628d5912db41d85ae0314"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.22-110444/wendy-cli-darwin-arm64-2026.04.22-110444.tar.gz"
    sha256 "c149f8cc8c3124ae93c3e66b182f906d4bb982f2d493906cd8f56a25663a4177"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.22-110444/wendy-cli-linux-arm64-2026.04.22-110444.tar.gz"
      sha256 "b3bc36c8702e67d51eed4e552a652724249d3fb305e4d16924dfe943e5843df0"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.22-110444/wendy-cli-linux-amd64-2026.04.22-110444.tar.gz"
      sha256 "ff53f4b215f30b2915431ea3d1a64faf5ee00303d38918db2d8f5447242803ab"
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
