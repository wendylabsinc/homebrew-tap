class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.04.21-133945-dev"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "e24007e65a22c37a3bb89e207f844de5e46d89615c4fafac30ebeca224cf1859"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.21-133945-dev/wendy-cli-darwin-arm64-2026.04.21-133945-dev.tar.gz"
    sha256 "9ad0be4d8a09613aa6fdc0d32c14b17d9cc02dd4c3204057f75b4faf358894aa"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.21-133945-dev/wendy-cli-linux-arm64-2026.04.21-133945-dev.tar.gz"
      sha256 "b73ae135b8421aa55fcf371a3e6176124c6f97e974be5cfba0228b31e6cc8496"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.21-133945-dev/wendy-cli-linux-amd64-2026.04.21-133945-dev.tar.gz"
      sha256 "f920188b44d1e1cff23ae9e311d95e3af54854e633a49ea508e423546ba86ace"
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
