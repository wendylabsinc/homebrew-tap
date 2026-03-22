class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.03.22-111658"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "61368415997b2c41af26bdbf7efd8b58424ab4301365eb55a6259d34d1fbd5b7"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.22-111658/wendy-cli-darwin-arm64-2026.03.22-111658.tar.gz"
    sha256 "145b1c023417d74e44bf3ed06dea257cf91fd402134a2e011ca72735d29db5b0"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.22-111658/wendy-cli-linux-arm64-2026.03.22-111658.tar.gz"
      sha256 "7b02e0b7afd7d0bc8060133f609e1b751ad71877dfcc36c38de38e6b92f86459"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.22-111658/wendy-cli-linux-amd64-2026.03.22-111658.tar.gz"
      sha256 "3c75236b628d98f458a6549434a2de57036fd18c1d48722d1b3265894fa150c2"
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
