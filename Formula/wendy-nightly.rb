class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.05.02-014912"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "ed3e971a0fae49b9790b0ef9a46e26cb767a4910d234d3542aefdd4e7a1d9a13"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.05.02-014912/wendy-cli-darwin-arm64-2026.05.02-014912.tar.gz"
    sha256 "132b07b3229fcb9fb09e5dbb16c13ddda7bd6243150f7c4b116ff2ae7f6d37f8"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.05.02-014912/wendy-cli-linux-arm64-2026.05.02-014912.tar.gz"
      sha256 "f7cc65f72c3b5a39af0d662cabf26e2dcd44aee7f825b09f5785250bc6ea031c"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.05.02-014912/wendy-cli-linux-amd64-2026.05.02-014912.tar.gz"
      sha256 "6a0d6a794199ffb2db72be39e5b1401349219bc269db0137334d9ff722bede09"
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
