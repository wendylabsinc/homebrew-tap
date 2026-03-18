class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.03.18-183838"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "e260dad191558948f1825246eba7627452c1c39a2fb2e9b7642c75f785b13a05"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.18-183838/wendy-cli-darwin-arm64-2026.03.18-183838.tar.gz"
    sha256 "586526eb077e2bbe078809e7904d1428b939bc6200f5fcc9d4184ed28d9f71b0"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.18-183838/wendy-cli-linux-arm64-2026.03.18-183838.tar.gz"
      sha256 "44bcb65c5ef103c1074fcec7bb87df60ee87046b4b3a8ce528179779b2f6523d"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.18-183838/wendy-cli-linux-amd64-2026.03.18-183838.tar.gz"
      sha256 "29635f900b59ccbc22860269a19c76b34d383ffcf154f08975d16f097ff328f1"
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
