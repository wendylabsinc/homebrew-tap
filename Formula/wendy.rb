class Wendy < Formula
  desc "CLI for building and running WendyOS applications"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-2026.04.17-073307"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "9766d42abc68f168ce98a999b25262ff94c8f597d4b5007c5787ef82987bb368"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.17-073307/wendy-cli-darwin-arm64-2026.04.17-073307.tar.gz"
    sha256 "752ffaf5c439d03b84e839f04d87b34b7acd90a32c5cf27da581911ebccc7da3"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.17-073307/wendy-cli-linux-arm64-2026.04.17-073307.tar.gz"
      sha256 "c9ba572365149525a5d1535d6bdfe662ae44d01575103c0c965f0166720afaef"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.17-073307/wendy-cli-linux-amd64-2026.04.17-073307.tar.gz"
      sha256 "13a443ff0fcda1cce39138e48b64b38e681af1e8a121801037c8f36804339d57"
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
