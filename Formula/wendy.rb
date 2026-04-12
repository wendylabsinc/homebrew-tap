class Wendy < Formula
  desc "CLI for building and running WendyOS applications"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-2026.04.12-194615"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "7c73d61121350ab8756174618e19f2250d61f4802503645eae75e8384a48df09"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.12-194615/wendy-cli-darwin-arm64-2026.04.12-194615.tar.gz"
    sha256 "02f523bb4f4f93acb51624e196633e889b01fafe031847dc7114e6ec56cea719"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.12-194615/wendy-cli-linux-arm64-2026.04.12-194615.tar.gz"
      sha256 "bcbdc89ef43f92ec323807a48095bd25ace58f63b1db7706a800442f18b8aa71"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.12-194615/wendy-cli-linux-amd64-2026.04.12-194615.tar.gz"
      sha256 "38b905ea0a3996175ded08aac603238335e9ccd757737c5fdf2f5048ff2ef40f"
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
