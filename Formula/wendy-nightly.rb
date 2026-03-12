class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.03.12-183952"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "75e45304fdaa3cda013b4c168b6af0293d1667be68d1827ac7f7234235f0086e"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.12-183952/wendy-cli-darwin-arm64-2026.03.12-183952.tar.gz"
    sha256 "580047a7a2963604075983ff19ae59bcf88edb3340b0c953a3bec52b1c447452"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.12-183952/wendy-cli-linux-arm64-2026.03.12-183952.tar.gz"
      sha256 "e93a8d2eb13ad0cfbff8dcfb052595eef7b045c4fe125d2d414c33f0e0e19f54"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.12-183952/wendy-cli-linux-amd64-2026.03.12-183952.tar.gz"
      sha256 "24803aa042fa80f3b961cc89d67574c7bd4522baaf9ae63970a894d9f8e32c65"
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
