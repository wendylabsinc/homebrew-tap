class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.04.02-160840"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "ae5f48e7856463a427f18a82579d844a5389d82e4f4be5f2f0f0265272d5389b"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.02-160840/wendy-cli-darwin-arm64-2026.04.02-160840.tar.gz"
    sha256 "949a21642e3d613e69f95d3ec3d0c8f2fea589151584b047048786d6ef607618"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.02-160840/wendy-cli-linux-arm64-2026.04.02-160840.tar.gz"
      sha256 "948bfa9a29b5bd8f6540ec4ec1f9aad49772b871212a7f553538ad3c8cdf07b0"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.02-160840/wendy-cli-linux-amd64-2026.04.02-160840.tar.gz"
      sha256 "65f293377920cd78c81ad27dc53083b5dee1e60e27f6493b2730591392ac363a"
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
