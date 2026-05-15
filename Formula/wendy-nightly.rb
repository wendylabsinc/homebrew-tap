class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.05.15-221130"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "aee879e9abea994797330d2b648a240fadfc2d6a48f29b08be497422ed95b25e"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.05.15-221130/wendy-cli-darwin-arm64-2026.05.15-221130.tar.gz"
    sha256 "6c2ec5c19275bb0f4ec19f407f2c9c748a9a69326c30ee58aaa63c7ef0c40d46"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.05.15-221130/wendy-cli-linux-arm64-2026.05.15-221130.tar.gz"
      sha256 "9517932f17e2447d39d970607b64bd138e3b0da5212d63938f822f92c1a93ed0"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.05.15-221130/wendy-cli-linux-amd64-2026.05.15-221130.tar.gz"
      sha256 "a17d756c100fc1fea532ea89ca3e02c6852b3260ae01a649258c188942c18bf2"
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
