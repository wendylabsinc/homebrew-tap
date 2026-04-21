class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.04.21-192043"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "b07a8057070036b10ff91e5c73378b4ebffa622b23bfd0c50df9a233a3fe26b9"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.21-192043/wendy-cli-darwin-arm64-2026.04.21-192043.tar.gz"
    sha256 "666d33f7fed90512de70ced4733d22a258e1a5e0377bcdf0bbee016246bd2af5"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.21-192043/wendy-cli-linux-arm64-2026.04.21-192043.tar.gz"
      sha256 "b1a83dd79699fb978a5f2e7ec257d0d5f497db5d06b7f4bc55c74a38802bdba3"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.21-192043/wendy-cli-linux-amd64-2026.04.21-192043.tar.gz"
      sha256 "5e3d12c6aca5adfbb20b7de26b5c09e55c0b12fee4d2005577b6420ea28546e9"
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
