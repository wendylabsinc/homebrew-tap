class Wendy < Formula
  desc "CLI for building and running WendyOS applications"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-2026.04.20-135532"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "e1e15898409005310dda4f62eba9ef3b6f9d8211fdcf0c7aaae7a7fc6065e367"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.20-135532/wendy-cli-darwin-arm64-2026.04.20-135532.tar.gz"
    sha256 "fa86b6d12e9707181f86358a5ad5292291f335d0e9cb4e769a875f4de70772a9"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.20-135532/wendy-cli-linux-arm64-2026.04.20-135532.tar.gz"
      sha256 "2d6e97de4a30f672f5e5ad2feb3c2238b19c75ee5c37fcaa7dd9fbb279ea7246"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.20-135532/wendy-cli-linux-amd64-2026.04.20-135532.tar.gz"
      sha256 "aec509b0235dadb8ad58e96a37f606d86225efc9504186f079bff547d06f5d43"
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
