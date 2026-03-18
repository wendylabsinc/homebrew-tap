class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.03.18-183300"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "df1f24ff19a469384d2c7f296f30ba1b76e2f52d0f2d2ce6420e78879223112d"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.18-183300/wendy-cli-darwin-arm64-2026.03.18-183300.tar.gz"
    sha256 "c7ada4f54c48dea6d4aeb75fbd2f83827ab9423d8fd1ef82f5effc09b97c94a6"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.18-183300/wendy-cli-linux-arm64-2026.03.18-183300.tar.gz"
      sha256 "c78a732df6820c278d1872015d81135fe024ab8ab793a23ec39471e53b467c63"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.18-183300/wendy-cli-linux-amd64-2026.03.18-183300.tar.gz"
      sha256 "b5660c2400fc4de4b19d2dfe96a16582ddecc97ab465af8d4ff873eeb1fdbe05"
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
