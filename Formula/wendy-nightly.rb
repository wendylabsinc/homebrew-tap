class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.03.30-155032"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "569b9cabe0920ae28d9ba245781fc919945d3abeb926cc52cc726d0380dcbe68"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.30-155032/wendy-cli-darwin-arm64-2026.03.30-155032.tar.gz"
    sha256 "f43e3298428ad3f03cb15f0d09f0dbff4802048c59a14a7a35caa505826973e7"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.30-155032/wendy-cli-linux-arm64-2026.03.30-155032.tar.gz"
      sha256 "3ddf7d4519c186067193c844e240b043157d4a9a7d45d711f311e22560e0f6f3"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.30-155032/wendy-cli-linux-amd64-2026.03.30-155032.tar.gz"
      sha256 "99135d25d733998767d9be63803511a16ae0e1c2b5bd021b81f43167a2033345"
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
