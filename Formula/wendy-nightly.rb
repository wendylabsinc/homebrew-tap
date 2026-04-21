class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.04.21-233450"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "34f393011ee45a5ef4e6675881c386f35a1378c47ce5a6a02477d1f03e7893a0"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.21-233450/wendy-cli-darwin-arm64-2026.04.21-233450.tar.gz"
    sha256 "b810493141ffcaf33533ad6b6f04f78b22d30dc4cd9c0c496a27cb8620392ceb"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.21-233450/wendy-cli-linux-arm64-2026.04.21-233450.tar.gz"
      sha256 "c7e13bcb7988a8bf7a27a6072bcb28e2212198bc3a50563c59d580f856f943e1"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.21-233450/wendy-cli-linux-amd64-2026.04.21-233450.tar.gz"
      sha256 "27e75d20138b60f9a2e56b45e37251b8d10da60abbae64a48954ebc305012579"
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
