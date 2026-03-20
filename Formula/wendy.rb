class Wendy < Formula
  desc "CLI for building and running WendyOS applications"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-2026.03.20-015852"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "b8a144f707786501d1413d19e842ec5e47374e6b59d0ae02dcb7b9f9a322206d"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.20-015852/wendy-cli-darwin-arm64-2026.03.20-015852.tar.gz"
    sha256 "6cd178f7630fc8de02c2b8117e5f2388e79081cdb28befe5d4b9c5deaaeaadf2"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.20-015852/wendy-cli-linux-arm64-2026.03.20-015852.tar.gz"
      sha256 "ac792278bd02fe3e9b8986f7282e001d5415fd6d45f0f044b9f7d673ec6d43dd"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.20-015852/wendy-cli-linux-amd64-2026.03.20-015852.tar.gz"
      sha256 "bd66c927c3a6959c7c75f6c31c970631e580b0922ab016200bac6c08bc25e8f3"
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
