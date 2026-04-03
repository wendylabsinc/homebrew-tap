class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.04.03-085629"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "5ee60cffdf7dc46e7976d36c7c6df14854a4d5847b3447eb74a1660345113382"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.03-085629/wendy-cli-darwin-arm64-2026.04.03-085629.tar.gz"
    sha256 "0ca8727f0707c39e361e8bca62cb29e2a843e1c61361e10ab943d39561357e09"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.03-085629/wendy-cli-linux-arm64-2026.04.03-085629.tar.gz"
      sha256 "a005d66a5d5fce1469d268beb73175bc83621bff0a7b3b96894969ef82b35e5e"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.03-085629/wendy-cli-linux-amd64-2026.04.03-085629.tar.gz"
      sha256 "de79fe5a92d66816292bb235e33c53fa98a46a437cdaff9ddb41aae4ea0207b3"
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
