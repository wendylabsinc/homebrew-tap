class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.03.20-144610"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "1a04dc6ae233609379f7b63d1e0b6871b853b47a0824b09110e6c9edcff7dc32"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.20-144610/wendy-cli-darwin-arm64-2026.03.20-144610.tar.gz"
    sha256 "f392e7653b48ec6460df6c2e073e4ccf7bfcbdea0ea00055144b044650f4fec6"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.20-144610/wendy-cli-linux-arm64-2026.03.20-144610.tar.gz"
      sha256 "9b96ecdbcc8d6ebe5b9d20ab7ac23d1060af287407621b2fe30c08c9539db90c"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.20-144610/wendy-cli-linux-amd64-2026.03.20-144610.tar.gz"
      sha256 "96821df3a5973d8511c129e29916fe74e01d45a97e232fefff43a2382d88fcda"
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
