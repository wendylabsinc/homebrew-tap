class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.05.04-121659"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "3f6042be7cf67921e9b4e5f4f8affba959a75ade5ad144700dd6c8653a0213c6"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.05.04-121659/wendy-cli-darwin-arm64-2026.05.04-121659.tar.gz"
    sha256 "54dd0e3abbd0d9845a2f9faf38a8c02ef83eb9ae8e716b8cc886879c67587612"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.05.04-121659/wendy-cli-linux-arm64-2026.05.04-121659.tar.gz"
      sha256 "8cc23002f78f76d4545ad2d8444fc9ccc6254e69f5e2e270573cf18d9fc1aa22"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.05.04-121659/wendy-cli-linux-amd64-2026.05.04-121659.tar.gz"
      sha256 "3bdca56eaa354f55e45c36deb8e51eb3c4ffc8719ad72db6a80d52f48df886de"
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
