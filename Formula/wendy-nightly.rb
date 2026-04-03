class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.04.03-172541"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "6999b4e493692c33e8c5f271e7f08b2a0006602b86ae4a700f3a16f7dc49a01f"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.03-172541/wendy-cli-darwin-arm64-2026.04.03-172541.tar.gz"
    sha256 "3b823e5b3806b69fd5a634c052ed8aaa0471ce8dcf213972534c61e0d824c9b0"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.03-172541/wendy-cli-linux-arm64-2026.04.03-172541.tar.gz"
      sha256 "24da7834edda4e93f18f58512a3d824a3b122f065c6ce74779ad1ed00c81763f"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.03-172541/wendy-cli-linux-amd64-2026.04.03-172541.tar.gz"
      sha256 "75b13b8d1e678159217a4a889f307d69380be1ca55be58b4d6716c1540514d82"
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
