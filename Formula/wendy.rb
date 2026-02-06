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
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.02.06-002727/wendy-cli-macos-arm64-2026.02.06-002727.tar.gz"
    sha256 "0cf7964df57efefd3578025eee09527e9587f7ceb18f631d3aeaeeddb4d2e5e9"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.02.06-002727/wendy-cli-linux-static-musl-aarch64-2026.02.06-002727.tar.gz"
      sha256 "4f1e96f04bc6cec412eec51718daf92fd42f9f1ce22b3595502cbf0d46839991"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.02.06-002727/wendy-cli-linux-static-musl-x86_64-2026.02.06-002727.tar.gz"
      sha256 "959c5e14d7a5dc82892ea405026c78807fe5704c564d1674c8c37aa70ffc7cb1"
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
