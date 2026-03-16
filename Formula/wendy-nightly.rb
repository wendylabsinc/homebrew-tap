class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.03.16-163348"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "9ad8de524563480dff278c6d21369c449f724924fd622baa2a2fee77e97b4696"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.16-163348/wendy-cli-darwin-arm64-2026.03.16-163348.tar.gz"
    sha256 "88f5bff27f3f65f506b8e83653041a9ce3a8285b0bbbae27bd4177f583bb767b"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.16-163348/wendy-cli-linux-arm64-2026.03.16-163348.tar.gz"
      sha256 "33cd8b50b6e07c042988f85cb084aca250f01990424c458e282b97a3689e9749"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.16-163348/wendy-cli-linux-amd64-2026.03.16-163348.tar.gz"
      sha256 "3035d89bda89405cca8a4bdbce2cc3963e9bba244e66f0e5f7574ca05c64d6b8"
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
