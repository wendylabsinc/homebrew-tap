class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.04.21-191612"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "b07a8057070036b10ff91e5c73378b4ebffa622b23bfd0c50df9a233a3fe26b9"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.21-191612/wendy-cli-darwin-arm64-2026.04.21-191612.tar.gz"
    sha256 "32faafd7f1516ab8c07d7be4d6137c2f0d0bf22c8434ad4f0d584d0e8577b59f"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.21-191612/wendy-cli-linux-arm64-2026.04.21-191612.tar.gz"
      sha256 "67fa2bf52f5a160f11b0eedeff70bd2b61f634ee73f2899199ae30ea174a58f0"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.21-191612/wendy-cli-linux-amd64-2026.04.21-191612.tar.gz"
      sha256 "4c00174bf1b06be262b9a3dbf78695d03dacbb134540b3421648273225e133a6"
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
