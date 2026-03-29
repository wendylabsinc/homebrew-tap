class Wendy < Formula
  desc "CLI for building and running WendyOS applications"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-2026.03.29-181846"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "a6301104f572f5fa5ff13a8d3ce69c59da8b0152c6f63410b6750ceca0ff7278"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.29-181846/wendy-cli-darwin-arm64-2026.03.29-181846.tar.gz"
    sha256 "048bf77f37a7d87646a0348b5376856efdc1924584f88c03e5f6231db70ddaaa"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.29-181846/wendy-cli-linux-arm64-2026.03.29-181846.tar.gz"
      sha256 "c50c5faa8c63c30608b3f513ec10f2101e061b5796c783df9bed946f30a3a82a"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.29-181846/wendy-cli-linux-amd64-2026.03.29-181846.tar.gz"
      sha256 "918986c7aa9e750466f1824806788ceb186c241435ded8e020b1968baad9e19f"
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
