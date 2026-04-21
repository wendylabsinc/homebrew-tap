class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.04.21-171405"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "93a481d3a17d53cfb551adb4232b7201479a6e8a33451d8c49473a260139ab30"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.21-171405/wendy-cli-darwin-arm64-2026.04.21-171405.tar.gz"
    sha256 "6c104d69f037ec21d3d6e3dcf393b0e23f94e77a474d35b9d9b10303ae55fdee"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.21-171405/wendy-cli-linux-arm64-2026.04.21-171405.tar.gz"
      sha256 "af10a629b6f3bb38678d66b34ce328a38362bf3d9eb39d58f64b1639cf59ba4b"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.21-171405/wendy-cli-linux-amd64-2026.04.21-171405.tar.gz"
      sha256 "d0d11d612f9326edaa59bdae186a4dcb26261bd53fbddfda49b5f125e6aaea66"
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
