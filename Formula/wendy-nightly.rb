class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.04.17-105241"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "22cb28053c1d8eaa98a48a96060b63bf838b9195ec06ce09a27fb8f613897695"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.17-105241/wendy-cli-darwin-arm64-2026.04.17-105241.tar.gz"
    sha256 "8ec334b3076d4ed7539ac3656f1ff7b2ed8f115ac2ff62b3c2fa5ebc81d75c16"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.17-105241/wendy-cli-linux-arm64-2026.04.17-105241.tar.gz"
      sha256 "8ad83982002e033e30be44bca333c3a3592d9fd459a41351c6db4fc1daa10fd1"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.17-105241/wendy-cli-linux-amd64-2026.04.17-105241.tar.gz"
      sha256 "e50089b73858c6c33ca17a72c4e5a7387fdc71866bd30071947e007a4fd88a1e"
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
