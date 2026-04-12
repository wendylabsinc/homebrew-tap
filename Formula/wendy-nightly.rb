class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.04.12-041057"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "1cdf3998dd6f54b3b102819e3e0a55d3ffbd273ed782e57182b975774e653b1f"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.12-041057/wendy-cli-darwin-arm64-2026.04.12-041057.tar.gz"
    sha256 "1553f0d51301d671c92e57796329b21e0582697301a03939c36e6b1f92825cbf"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.12-041057/wendy-cli-linux-arm64-2026.04.12-041057.tar.gz"
      sha256 "a70e5e1e86fbafb729d4c79acf41871574f1451fbeef0dd544b7dc99a11df3d7"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.12-041057/wendy-cli-linux-amd64-2026.04.12-041057.tar.gz"
      sha256 "e136ad5cad532569d683d72dc444fa7f25e1f55cb33f384da7a7b801d4b9cde0"
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
