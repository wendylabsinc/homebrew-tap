class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.05.01-114334"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "5929b9ae3766d47808c58ec04c4b3ad0c3868d009290db963d00301482628452"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.05.01-114334/wendy-cli-darwin-arm64-2026.05.01-114334.tar.gz"
    sha256 "37943f11390e69916dcb616b4ce4e2b2b2e7631c2d17948c3bc1a569c71c3613"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.05.01-114334/wendy-cli-linux-arm64-2026.05.01-114334.tar.gz"
      sha256 "e1afa83ce115126df253431f72cac1f0aa301f5b94f28531cd99895dafbb3dac"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.05.01-114334/wendy-cli-linux-amd64-2026.05.01-114334.tar.gz"
      sha256 "82a84ba1a5aba80ab44ab5d35938aa8f33c25ff6c331c6855bf7394c522ec5d9"
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
