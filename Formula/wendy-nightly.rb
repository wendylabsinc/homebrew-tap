class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.05.18-211056"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "bd317d3c8562de9b02ebb0d4be0f93aa4d109e4f40b72203aa48b529d1b45f38"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.05.18-211056/wendy-cli-darwin-arm64-2026.05.18-211056.tar.gz"
    sha256 "f7a0f54d163e9e681e7f5ecb8d7949d3e6c87e5dbe755567bf723bc6d96db3be"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.05.18-211056/wendy-cli-linux-arm64-2026.05.18-211056.tar.gz"
      sha256 "ff572a1dadfcd72b61fdf3061737cf938832116f11ed585d6c9315e4233b58d6"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.05.18-211056/wendy-cli-linux-amd64-2026.05.18-211056.tar.gz"
      sha256 "507dce96ee5c30543173090a7be44ff2651d43b1963041d83e92f82659b4d25f"
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
