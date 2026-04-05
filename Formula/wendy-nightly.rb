class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.04.05-100727"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "5415711270e82997b12d21559ac18eb94b4428bfb3c4ce66d822ea0e587b518a"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.05-100727/wendy-cli-darwin-arm64-2026.04.05-100727.tar.gz"
    sha256 "8a82c5883bacfcd6e4b67f45c15d77ecae6ace3df98d033111dce3f743f4c306"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.05-100727/wendy-cli-linux-arm64-2026.04.05-100727.tar.gz"
      sha256 "c09f0d798e5008f7e5cbdc955eb6829a098c1d00db4ae9783f048d1bac97d1b8"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.05-100727/wendy-cli-linux-amd64-2026.04.05-100727.tar.gz"
      sha256 "100a2258a00611715f2f43e6d48cea69e64d78b6c82f52e2bc2b825d8aca23f8"
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
