class Wendy < Formula
  desc "CLI for building and running WendyOS applications"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-2026.03.21-124319"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "972186f9a6be9bb4c3dce81b8fe67e7c9f9cac975ddb950a9878d2fad309f5f0"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.21-124319/wendy-cli-darwin-arm64-2026.03.21-124319.tar.gz"
    sha256 "6716f8266ef3e8ff097955adaacd0e082cd5aaee6edf8342eaeb20afdb3724e1"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.21-124319/wendy-cli-linux-arm64-2026.03.21-124319.tar.gz"
      sha256 "9d497f32629995245f9c3070bb6ea29c38ad4c96b4fab1aa3910000e48c21b65"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.21-124319/wendy-cli-linux-amd64-2026.03.21-124319.tar.gz"
      sha256 "b3a1149d874a55d84fadc67b4b543953d31b24ea48597d8806ed8c1f05a3f154"
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
