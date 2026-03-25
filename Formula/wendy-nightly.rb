class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.03.25-195512"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "d69ea7a7472bf49395858df458d29eaaf37a10b5a11d0e2d1749a15b3791f407"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.25-195512/wendy-cli-darwin-arm64-2026.03.25-195512.tar.gz"
    sha256 "c41c9be017f9642b37aaf72c6cf1395f587a611074c9b279f439cd42ce43ea15"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.25-195512/wendy-cli-linux-arm64-2026.03.25-195512.tar.gz"
      sha256 "c014a1ee95ef03943450f0c1141c6a7fb670be8be4dcb36ffcfa32c3ed38970f"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.25-195512/wendy-cli-linux-amd64-2026.03.25-195512.tar.gz"
      sha256 "b9fa95d8fabeb455e8837c2f04e304ffbc2c821727b8ccc2f2dae95126bf1fd2"
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
