class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.04.01-073347"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "c65348e7b4c1807b224f81ed654472bb41ac72655358800281bce06f5c474c19"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.01-073347/wendy-cli-darwin-arm64-2026.04.01-073347.tar.gz"
    sha256 "3ee5b005de59b3a9085fe6077ff6e3f6c3f099b9f7343e732144c5a832ad59ff"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.01-073347/wendy-cli-linux-arm64-2026.04.01-073347.tar.gz"
      sha256 "57c0ce52ed209663e09a0a9a785d31e3790ebe8de353b8ad202f0549fc5c84b6"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.01-073347/wendy-cli-linux-amd64-2026.04.01-073347.tar.gz"
      sha256 "f88bdb81a2ad2c4f6034e9ba531e7484e4db84603bc2c1df2574464ef00ff618"
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
