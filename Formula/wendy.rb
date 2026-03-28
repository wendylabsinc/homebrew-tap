class Wendy < Formula
  desc "CLI for building and running WendyOS applications"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-2026.03.28-014723"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "1195de41757118eb06e9475d2704f5e7340e97aa03e19d38040e5e71896391c8"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.28-014723/wendy-cli-darwin-arm64-2026.03.28-014723.tar.gz"
    sha256 "6880148d5433a38b94c99d4ea414a5b0c928e14212b1666beffb99598ceaefb1"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.28-014723/wendy-cli-linux-arm64-2026.03.28-014723.tar.gz"
      sha256 "4220c37f1b9b29a4dced867a494c66ea846857e19081d45de825c31ceef6cf1e"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.28-014723/wendy-cli-linux-amd64-2026.03.28-014723.tar.gz"
      sha256 "ea6074550e887bba9d39cb9ab196307846d695b09a97f2e12255f3ac93d44ff6"
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
