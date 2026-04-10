class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.04.10-180155"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "1cdf3998dd6f54b3b102819e3e0a55d3ffbd273ed782e57182b975774e653b1f"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.10-180155/wendy-cli-darwin-arm64-2026.04.10-180155.tar.gz"
    sha256 "d046ff44f2cdc3ea328271684656e408892bfc34b4b6afb1047b5b5703af8cc2"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.10-180155/wendy-cli-linux-arm64-2026.04.10-180155.tar.gz"
      sha256 "dd764a61eb7df92d15e5fe09f3a62553dc87714d8987e39843811c5f39488068"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.10-180155/wendy-cli-linux-amd64-2026.04.10-180155.tar.gz"
      sha256 "ac22ad5ba6712aded8ce93438e6c91b9c16a40d7897578fa934e379cac6019a3"
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
