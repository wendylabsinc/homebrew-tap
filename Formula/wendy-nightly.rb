class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.05.17-000308"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "09a23976c06e5e33f851eb67a1fdff7552e64b8ca0ab0ab50154db1144f42df1"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.05.17-000308/wendy-cli-darwin-arm64-2026.05.17-000308.tar.gz"
    sha256 "0759bd034f146c0a87f354dc2a62f6793ff5dd08c624ef464c755f82ff4d6372"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.05.17-000308/wendy-cli-linux-arm64-2026.05.17-000308.tar.gz"
      sha256 "7a423a5bf8d102f2ba4dbf0c0d589e9830cf6eeff720facd1ca9311a973f3f12"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.05.17-000308/wendy-cli-linux-amd64-2026.05.17-000308.tar.gz"
      sha256 "ec551e361418afd782f62584234662f2e08330ffefc1622a4088f2b2248ba5fe"
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
