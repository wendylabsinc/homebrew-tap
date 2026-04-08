class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.04.08-214841"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "b86425e8e72c32676501ae679bc6f87a336edee61525fff09c4f9871b73a63c8"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.08-214841/wendy-cli-darwin-arm64-2026.04.08-214841.tar.gz"
    sha256 "c629a2bb327f6d3901a1305a44897609757aad253e34a4e4f164f26b6fa631f6"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.08-214841/wendy-cli-linux-arm64-2026.04.08-214841.tar.gz"
      sha256 "31fb0acb2feea8d9ca4c262719be39be11430110ff4e7afc854aecab371346d7"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.08-214841/wendy-cli-linux-amd64-2026.04.08-214841.tar.gz"
      sha256 "f3f716130469c3aa5f69512c24f01794d438dce0e790ed585e91f375ad62b0e6"
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
