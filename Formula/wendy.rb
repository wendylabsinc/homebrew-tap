class Wendy < Formula
  desc "CLI for building and running WendyOS applications"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-2026.03.27-112453"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "1195de41757118eb06e9475d2704f5e7340e97aa03e19d38040e5e71896391c8"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.27-112453/wendy-cli-darwin-arm64-2026.03.27-112453.tar.gz"
    sha256 "0401e2c19b46e376c079ed669704ec37e285a154184106e15cade630f97ddb99"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.27-112453/wendy-cli-linux-arm64-2026.03.27-112453.tar.gz"
      sha256 "e8100eef3dace01f2f5b92665cc9a349d24a8b51fce88884712a2a671d6bdf43"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.27-112453/wendy-cli-linux-amd64-2026.03.27-112453.tar.gz"
      sha256 "74742e7cab3a6aa95575dd4ae6796b564f495deb1a19a95666768f10f2da32af"
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
