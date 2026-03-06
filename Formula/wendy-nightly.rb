class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.03.06-091536"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "a8643d5bf87b0bc9033e01e2e84b11f4381eba321360e6529bbec9ce3d76c7e9"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.06-091536/wendy-cli-darwin-arm64-2026.03.06-091536.tar.gz"
    sha256 "51c94fb3488d1f0697af503f0ae61544f1be4e7bee121405505722188a138384"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.06-091536/wendy-cli-linux-arm64-2026.03.06-091536.tar.gz"
      sha256 "7ce1d60cda0e2a424029af9ad8dde47c1d986c5ace044c7e180c5da2d02f4e97"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.06-091536/wendy-cli-linux-amd64-2026.03.06-091536.tar.gz"
      sha256 "809db4da353739fd3e0b285200783b83f5961527e2963ccc0eda8deff1bbc512"
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
