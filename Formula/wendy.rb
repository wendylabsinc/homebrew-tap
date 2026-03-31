class Wendy < Formula
  desc "CLI for building and running WendyOS applications"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-2026.03.31-181059"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "3f3b51b8d11b04cb1bd42ba6ce6bb45ad20dc5b601b5867e8d40b9a3252a09ce"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.31-181059/wendy-cli-darwin-arm64-2026.03.31-181059.tar.gz"
    sha256 "01ae882276f20630f6955a7e057c52aaf5f35ed7c5ba31f8741b01c56b7c1560"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.31-181059/wendy-cli-linux-arm64-2026.03.31-181059.tar.gz"
      sha256 "703c24655c22b72236ac7daa4ba3afaef1dd9874dfc6e729056e66184e637730"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.31-181059/wendy-cli-linux-amd64-2026.03.31-181059.tar.gz"
      sha256 "00e48146afb758578b0649d8263b304f47173b1f53c1d01a74b4618990731039"
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
