class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.03.18-142112"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "0d74e6a744170b11ad21005dc543f9220ba8d0d33c67bd2395f4c07c3e6a1e61"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.18-142112/wendy-cli-darwin-arm64-2026.03.18-142112.tar.gz"
    sha256 "b0acb97de4e15f5d5f19fb7a13a2eb0007f8c2bdfe28035dab446edbddc036da"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.18-142112/wendy-cli-linux-arm64-2026.03.18-142112.tar.gz"
      sha256 "fd95b634234ae6b91e27009406a49fba543a514cc7b679898dace3a83fcafc24"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.18-142112/wendy-cli-linux-amd64-2026.03.18-142112.tar.gz"
      sha256 "a064b3b3cba27e331669b3af11c7b9019c1e9b3a2283b5825e7d64207a14ed04"
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
