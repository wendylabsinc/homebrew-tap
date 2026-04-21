class Wendy < Formula
  desc "CLI for building and running WendyOS applications"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-2026.04.21-152222"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "8e5ee92002248877d7e76abe2b82f07e4a2e38001dcb22812c577c47d5858d2a"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.21-152222/wendy-cli-darwin-arm64-2026.04.21-152222.tar.gz"
    sha256 "e1f9b4c71249e2c19ad8da3e2f23d205cf9559742ced6e1b636e7acb99ca179f"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.21-152222/wendy-cli-linux-arm64-2026.04.21-152222.tar.gz"
      sha256 "160050b7ed0dc384a6a8865d233bd98f2210dc8ad5684f6df0a14da784ccbbdd"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.21-152222/wendy-cli-linux-amd64-2026.04.21-152222.tar.gz"
      sha256 "3eda24c62ecd67f341252d0082ead5d220c02011ec65651ed5c5fbcdf574edc0"
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
