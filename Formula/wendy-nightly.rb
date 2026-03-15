class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.03.15-194405"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "4b2069c7f2833fee1fce5d430c146c1f2c238e92a71b2af5a62799055a5a2315"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.15-194405/wendy-cli-darwin-arm64-2026.03.15-194405.tar.gz"
    sha256 "7b1d54c6ff195482e050d1d379fb4bfd9b2dc845e411092f39e9e399152b4e9b"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.15-194405/wendy-cli-linux-arm64-2026.03.15-194405.tar.gz"
      sha256 "76924d4e82c3d6c5076abe07f4d265da57a59fa5d9947bcf13e4113e486f1d04"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.15-194405/wendy-cli-linux-amd64-2026.03.15-194405.tar.gz"
      sha256 "fa9dbc0d6e1b2a7f02cda9a4c110bd9192b1c03194835646152975c1f2f71644"
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
