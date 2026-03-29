class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.03.29-212233"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "d4f97e2619f2be3fc733643ed19d5fe6706a719a2242d82bbb6b558a284e4537"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.29-212233/wendy-cli-darwin-arm64-2026.03.29-212233.tar.gz"
    sha256 "dc145627d9eab1d50a67977fb8b961e7349ab0b62f211d5883a9773e2306348d"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.29-212233/wendy-cli-linux-arm64-2026.03.29-212233.tar.gz"
      sha256 "31d1f0956fe31e19abaf3fbf0802caa1e7d8116bfcb99da48d70fa011e059bd7"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.29-212233/wendy-cli-linux-amd64-2026.03.29-212233.tar.gz"
      sha256 "f7a438723b33267ac5cc34dddf7bd3b6714bf97254cab9c6b1ba63433037f8d9"
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
