class Wendy < Formula
  desc "CLI for building and running WendyOS applications"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-2026.04.08-220724"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "fd7062ebe51f6a3ac00def6586777b78485b905576e96253ec0d51442c192bc8"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.08-220724/wendy-cli-darwin-arm64-2026.04.08-220724.tar.gz"
    sha256 "a05e99766c60246169e893ab124c8342df3771ab777c01de7ade3fe20258d039"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.08-220724/wendy-cli-linux-arm64-2026.04.08-220724.tar.gz"
      sha256 "e9ef90332d8352ca61a68d7169a255c49a813a5ea41a6891b1ac8eda71c38d2c"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.08-220724/wendy-cli-linux-amd64-2026.04.08-220724.tar.gz"
      sha256 "27291d10c7273d237cecea98b22d3f2e46405bd05fbeea7a3b0b804e540c2eeb"
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
