class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.04.21-173914"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "2ac741a2fb3a9e185d47f586119edb5ffa1ada4bd52fe10a181ddf8e02ab8e2f"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.21-173914/wendy-cli-darwin-arm64-2026.04.21-173914.tar.gz"
    sha256 "5c2324cf1f82daeda1d403d23ebbf04ee73f10c531cf07d8805d35cfb3431fee"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.21-173914/wendy-cli-linux-arm64-2026.04.21-173914.tar.gz"
      sha256 "57855e7de9d2e49d7b913a879d3fd407f358e27e3d8301814d7ea41eb4ae9bdf"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.21-173914/wendy-cli-linux-amd64-2026.04.21-173914.tar.gz"
      sha256 "2f5cbd9815bc44d985ba625bb9f643233bda1e2b5a5d868bdcc1fb7397932531"
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
