class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.06.19-183302"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "a0121322024a0a8b1ee63ac1ad952909d2ae59635ef24fc00d6caba79c5c2280"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.19-183302/wendy-cli-darwin-arm64-2026.06.19-183302.tar.gz"
    sha256 "f5c818283de8f56c1935fa569bb39c6dbb2cc7078e6d6b43d1e43e246d167660"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.19-183302/wendy-cli-linux-arm64-2026.06.19-183302.tar.gz"
      sha256 "f4713640c62a1b17870e41ed072ce8c7734d64646452be353365b440cc26cd83"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.19-183302/wendy-cli-linux-amd64-2026.06.19-183302.tar.gz"
      sha256 "b6fcc34b405cecc8b20ad2260a7d8ae38c2937c65a4c6fe457fd956dfdf77583"
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

  def post_install
    quiet_system bin/"wendy", "completion", "install"
  end

  def caveats
    <<~EOS
      Attention: The Wendy CLI collects anonymous analytics.
      They help us understand which commands are used most, identify common errors, and prioritize improvements.
      Analytics are enabled by default. If you'd like to opt-out, use the following command:
        wendy analytics disable
      Or, set the following environment variable:
        WENDY_ANALYTICS=false

      To set up MCP integration with your AI tools:
        wendy mcp setup
    EOS
  end

  test do
    system bin/"wendy", "--help"
    assert_match "wendy [command]", shell_output("#{bin}/wendy --help")
  end
end
