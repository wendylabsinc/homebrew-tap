class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.03.29-175545"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "92f77e9aabd92fd5fd2717ccdcb02fda23b62d804f08398912a137c330b367a7"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.29-175545/wendy-cli-darwin-arm64-2026.03.29-175545.tar.gz"
    sha256 "170264f4054897335872096846a1ee7a1528ab249f69f096fa4cc6d792044661"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.29-175545/wendy-cli-linux-arm64-2026.03.29-175545.tar.gz"
      sha256 "5997549949a215ba3fb53668500de78105ad3a93795e383c71b1f630358550c7"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.29-175545/wendy-cli-linux-amd64-2026.03.29-175545.tar.gz"
      sha256 "9915044183dead5bf2e6b69fd399d18f933981a2899a7c16e8a817e0c1d9d517"
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
