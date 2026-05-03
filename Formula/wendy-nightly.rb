class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.05.03-131605"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "4c358df3481dc75bd35558928c54b5090fe9e996af5207362b3a717206c5ea1d"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.05.03-131605/wendy-cli-darwin-arm64-2026.05.03-131605.tar.gz"
    sha256 "77b6e85e29070b8250e992dbee81bf5326d85cdae27aa5c36e3260afafc89c35"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.05.03-131605/wendy-cli-linux-arm64-2026.05.03-131605.tar.gz"
      sha256 "b00e5c4e5112cf08653d7a14c8855a91ab12bce24db6f3d631fc555e6aeefb9e"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.05.03-131605/wendy-cli-linux-amd64-2026.05.03-131605.tar.gz"
      sha256 "3238137642433e69515ada6da5cf5fb9294673bfb6556c6677162857ea1591d4"
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
