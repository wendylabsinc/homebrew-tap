class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.04.21-133036"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "22d50bc31dc6d05ffd786f0ed3a059a10ddb9677c77de0a5f832904ebff2a873"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.21-133036/wendy-cli-darwin-arm64-2026.04.21-133036.tar.gz"
    sha256 "068dc6fee1ba3b7c8f577fb74529a9cf1a0260332f7d6c6ff85b94931f2475f0"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.21-133036/wendy-cli-linux-arm64-2026.04.21-133036.tar.gz"
      sha256 "6695eab603a7d1ee7e52b1cb21d6a42554d8a2d7698ac90150832e34ea23ef23"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.21-133036/wendy-cli-linux-amd64-2026.04.21-133036.tar.gz"
      sha256 "257278348adcdc9419827535397bf2926c77e8bab67b79293f9dd82dbb3ad0a5"
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
