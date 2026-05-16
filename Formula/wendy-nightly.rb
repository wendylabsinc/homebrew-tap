class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.05.16-195933"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "7b7857be19b1da3e999c6c83f7acf8254b53bce685ef50254763277e5b3b8e6a"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.05.16-195933/wendy-cli-darwin-arm64-2026.05.16-195933.tar.gz"
    sha256 "44c857f57b2ba2d992a359b8cf983c7f8b9b14ff1c1a5e0756ee7ee2b540ea0f"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.05.16-195933/wendy-cli-linux-arm64-2026.05.16-195933.tar.gz"
      sha256 "3f3ab60794fff9dfc25c015535cc407dda6c5cdf9da64a4a923753f8bcedac47"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.05.16-195933/wendy-cli-linux-amd64-2026.05.16-195933.tar.gz"
      sha256 "822c2c53af42aa87a4675612ccb1d669d31da09958c3f59ed723afab733310a5"
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
