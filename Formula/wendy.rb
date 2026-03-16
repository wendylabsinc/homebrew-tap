class Wendy < Formula
  desc "CLI for building and running WendyOS applications"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-2026.03.16-201912"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "2e99cfa8a44541aa649370047aabb1791aac3b6e218c95acadc284a38094e328"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.16-201912/wendy-cli-darwin-arm64-2026.03.16-201912.tar.gz"
    sha256 "5ce8009f45437ab4934067245993b02820efa20ea40f17ccc6ce8d5722785019"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.16-201912/wendy-cli-linux-arm64-2026.03.16-201912.tar.gz"
      sha256 "1fdbbb72a4a270e547282b03b1c38ceb952d3e9ca348660857ee3d10b1aa8187"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.16-201912/wendy-cli-linux-amd64-2026.03.16-201912.tar.gz"
      sha256 "22d6484633cc2e6a107b77929ed02093e1b6c4e9ceb2d21676645d4582273ab4"
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
