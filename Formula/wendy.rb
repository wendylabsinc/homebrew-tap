class Wendy < Formula
  desc "CLI for building and running WendyOS applications"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-2026.02.04-055115"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "6498a8fbb5aed5a21c31ce61d11262efb04e30ee39454969c380b143afcd6508"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.02.05-230015/wendy-cli-macos-arm64-2026.02.05-230015.tar.gz"
    sha256 "d62680338e028da596e2a6f292c3730075d665a8dee416733fe2405528de9c60"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.02.05-230015/wendy-cli-linux-static-musl-aarch64-2026.02.05-230015.tar.gz"
      sha256 "05fc3cecf9d3e35b3339e59fa4c35c834fe7ee54f12ca742b0918f62eef9c964"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.02.05-230015/wendy-cli-linux-static-musl-x86_64-2026.02.05-230015.tar.gz"
      sha256 "088026fcb025963e05a752dd3737b3bbc1aef540943ffa35e09512aa993b97fb"
    end
  end

  def install
    # Install pre-built binaries (all platforms)
    bin.install "wendy"
    bin.install "wendy-helper" if File.exist?("wendy-helper")
    bin.install "wendy-network-daemon" if File.exist?("wendy-network-daemon")

    # Install macOS-specific bundle with resources (plist files, etc) if present
    bundle_path = "wendy-agent_wendy.bundle"
    (lib/"wendy").install bundle_path if File.directory?(bundle_path)

    # Generate and install shell completions
    generate_completions_from_executable(bin/"wendy", "--generate-completion-script")
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
    assert_match "OVERVIEW: Wendy CLI", shell_output("#{bin}/wendy --help")
  end
end
