class Wendy < Formula
  desc "CLI for building and running WendyOS applications"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-2026.05.09-220252"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "eaa47ce2893abc2754d7a6d95c4fa97cf516bb4ce659a7bcfd373174868ef981"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.05.09-220252/wendy-cli-darwin-arm64-2026.05.09-220252.tar.gz"
    sha256 "be5a30c45fd08324c0a7f79f7abe6f7af12c0ac904d8bb775c9bcd2b3d2a8e8a"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.05.09-220252/wendy-cli-linux-arm64-2026.05.09-220252.tar.gz"
      sha256 "57e16a5d99bd7f542d15ce9f026a07a6f060dbc4543ed236ee8f2a5ae1ea5f12"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.05.09-220252/wendy-cli-linux-amd64-2026.05.09-220252.tar.gz"
      sha256 "631a80bac20454cbacaf01c5aacfdceaa85296a7d9564db01de094483130a89a"
    end
  end

  conflicts_with "wendy-nightly", because: "both install a `wendy` binary"

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
    # TODO: It would be better to actually build something, instead of just checking the help text.
    system bin/"wendy", "--help"
    assert_match "wendy [command]", shell_output("#{bin}/wendy --help")
  end
end
