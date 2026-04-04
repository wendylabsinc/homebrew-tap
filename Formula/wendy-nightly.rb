class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.04.04-154212"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "a5a001d1eca920db5dddce1f1cb028e781f0b1a71d5581684f53626137b5cd8d"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.04-154212/wendy-cli-darwin-arm64-2026.04.04-154212.tar.gz"
    sha256 "b2a732086e152169d7e6a1b46ea88d12fc1cb6888a9424b2ce3c4a69646497b6"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.04-154212/wendy-cli-linux-arm64-2026.04.04-154212.tar.gz"
      sha256 "a4a624abb617f07347e19a7bd6afe65289a7f79510c5271d4767adfce8f58fe3"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.04-154212/wendy-cli-linux-amd64-2026.04.04-154212.tar.gz"
      sha256 "d8fcdf0494724837dcaf6de9563d980d3ab8b9807e447acddbb062e54830690e"
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
