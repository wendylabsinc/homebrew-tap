class Wendy < Formula
  desc "CLI for building and running WendyOS applications"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-2026.04.17-222632"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "e1e15898409005310dda4f62eba9ef3b6f9d8211fdcf0c7aaae7a7fc6065e367"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.17-222632/wendy-cli-darwin-arm64-2026.04.17-222632.tar.gz"
    sha256 "1780c3da352a9a4879f246fd438e9f1399aaacc3a6563f4b8924db9b2fa7b4ca"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.17-222632/wendy-cli-linux-arm64-2026.04.17-222632.tar.gz"
      sha256 "5729cff5d5e64fd22f226cb390a6e3d0df728f14e55a29d90e32d38e35010ad7"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.17-222632/wendy-cli-linux-amd64-2026.04.17-222632.tar.gz"
      sha256 "a3cd3aa5906dbbb3aeca1286a3a3e09f2a0ef7f08eeb4237a601bc748c1b582a"
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
