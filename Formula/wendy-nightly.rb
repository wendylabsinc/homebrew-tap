class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.03.29-184957"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "d4f97e2619f2be3fc733643ed19d5fe6706a719a2242d82bbb6b558a284e4537"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.29-184957/wendy-cli-darwin-arm64-2026.03.29-184957.tar.gz"
    sha256 "a59baa6f8a3f4a8dbfe41edfb5bdb78285f4ae8dd68350e22173287518b52349"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.29-184957/wendy-cli-linux-arm64-2026.03.29-184957.tar.gz"
      sha256 "cbf2f1135db62e0634be3db335fcee84b3430fbe699f87898fdeb2920bf9f3d0"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.29-184957/wendy-cli-linux-amd64-2026.03.29-184957.tar.gz"
      sha256 "a817fe57e65c89cb71998bbbd89766a99ae167981aa96ebca6c02f8f1599cc67"
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
