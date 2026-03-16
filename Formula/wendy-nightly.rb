class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.03.16-200722"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "deecccc2dcead0c71b76632131550ea97a3910a8ce6e7bde3fe0e7b98f3cb2b3"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.16-200722/wendy-cli-darwin-arm64-2026.03.16-200722.tar.gz"
    sha256 "fb31b351fa7118582e09e9929e318e2ec71af26359fda17fd34d1735b7b7a5ca"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.16-200722/wendy-cli-linux-arm64-2026.03.16-200722.tar.gz"
      sha256 "5d4ad446494d51905a2bbf61eccc42a7253aaae85e9a49182f3b16f9114ea497"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.16-200722/wendy-cli-linux-amd64-2026.03.16-200722.tar.gz"
      sha256 "a42492fec2cc227db5324df547ecee37a3ac8ab30f6ecd8f38a3d2da00416f1b"
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
