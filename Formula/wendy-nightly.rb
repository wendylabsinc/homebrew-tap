class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.04.06-182649"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "a00ca9925f10a1f393ab6fd9bc94cf226afb99b18f078cccc524c0aef9b324b8"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.06-182649/wendy-cli-darwin-arm64-2026.04.06-182649.tar.gz"
    sha256 "aae6374ddef02d6e1e764c681e005380ddd67937ae3a58d2bbface308867183e"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.06-182649/wendy-cli-linux-arm64-2026.04.06-182649.tar.gz"
      sha256 "0a744796b5018943ce36b733630ea63ab95dbaa7af1af56f540d28f0bd8a060d"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.06-182649/wendy-cli-linux-amd64-2026.04.06-182649.tar.gz"
      sha256 "ba894e51cc65340c2b142d3fed2611caed5f6781b3ed7d30c0ed59c955035e40"
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
