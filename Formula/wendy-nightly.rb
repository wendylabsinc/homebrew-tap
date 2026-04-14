class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.04.14-124950"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "e85bac429fede4432130ff8c777846b356ae04b50ed99bf67873261c913215b8"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.14-124950/wendy-cli-darwin-arm64-2026.04.14-124950.tar.gz"
    sha256 "2eb212485069a9d16fb86b6d4caa4f81133106d9f62742d18f7519cee4a81493"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.14-124950/wendy-cli-linux-arm64-2026.04.14-124950.tar.gz"
      sha256 "b34f5b912db771e0e638b381ee108ba35853aa1e1815097e541d1b8eb0e70cc8"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.14-124950/wendy-cli-linux-amd64-2026.04.14-124950.tar.gz"
      sha256 "c88ed68c00c208b60c21b61f5b43c637989907306c960741d255761691dca667"
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
