class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.05.14-170103"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "f05aa1613df7e6484916815b8c34c0798781c8a47efcbc6f85f740a0d34e28fd"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.05.14-170103/wendy-cli-darwin-arm64-2026.05.14-170103.tar.gz"
    sha256 "45973ae940c0a959f8772743bbda41e25fa22c7ac813bd00f4d2a64bfe98c85a"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.05.14-170103/wendy-cli-linux-arm64-2026.05.14-170103.tar.gz"
      sha256 "074f3e9692282b33fa87bf9d7ddcf0e5720a10eda26691c494bf036fde3a674f"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.05.14-170103/wendy-cli-linux-amd64-2026.05.14-170103.tar.gz"
      sha256 "99856ee60072e16526709a38b9b2aabf7feac4b4c242601b7975cecd4f47e00b"
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
