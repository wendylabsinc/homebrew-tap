class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.03.18-192134"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "fb1217c9c5943d132d67206a24c548c20ab8525e81c14d69711da1538414d85d"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.18-192134/wendy-cli-darwin-arm64-2026.03.18-192134.tar.gz"
    sha256 "c6b9f5f1373128faa52a03dfe9c68618a598d3517b95127f82e943b2826ed7ce"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.18-192134/wendy-cli-linux-arm64-2026.03.18-192134.tar.gz"
      sha256 "48dbd8cc19bba01ff01588381b341d827e7eeabdc1b6f277dc9137ded89a2dfd"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.18-192134/wendy-cli-linux-amd64-2026.03.18-192134.tar.gz"
      sha256 "cb8055cf936103a47777c2809577443064500c2952a82ecef3f89975a390074b"
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
