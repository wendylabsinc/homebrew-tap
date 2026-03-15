class Wendy < Formula
  desc "CLI for building and running WendyOS applications"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-2026.03.15-163600"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "3a57e3b48a5d876575b0b3899f66a344da36ae1a083399eec36edee14e44e60b"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.15-163600/wendy-cli-darwin-arm64-2026.03.15-163600.tar.gz"
    sha256 "11c3641ede784ce3b38222182effd14caf68b7634dd25f8f9a9105bcaf688c09"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.15-163600/wendy-cli-linux-arm64-2026.03.15-163600.tar.gz"
      sha256 "8eb3746ffafe7539f0fc2ab5343c9540c2df8b5ad85b731a92ab391e596e2066"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.15-163600/wendy-cli-linux-amd64-2026.03.15-163600.tar.gz"
      sha256 "fdb4b28cd8e2fba0a582f2f59b71a21eb9c2e32640ced6cb1001af1bbaea2222"
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
