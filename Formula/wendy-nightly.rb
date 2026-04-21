class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.04.21-151147"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "e24007e65a22c37a3bb89e207f844de5e46d89615c4fafac30ebeca224cf1859"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.21-151147/wendy-cli-darwin-arm64-2026.04.21-151147.tar.gz"
    sha256 "62fd870d3b1f246bffebc0d691d6f6121b8213307842d015ed0ee8e905813445"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.21-151147/wendy-cli-linux-arm64-2026.04.21-151147.tar.gz"
      sha256 "140512d99222cbe72a809df36f2f559e4670db28781f7236089f8731dacd0e44"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.21-151147/wendy-cli-linux-amd64-2026.04.21-151147.tar.gz"
      sha256 "a381563c67fc6235ec5989a766e8a845d402b1537495529ca30efc5d95b5f706"
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
