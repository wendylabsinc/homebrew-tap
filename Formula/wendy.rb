class Wendy < Formula
  desc "CLI for building and running WendyOS applications"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-2026.02.02-084631"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "e1b29cdd4ca16b1c7062602cf2f6ad41993d4690e5607e33803132343c981c6d"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.02.02-093032/wendy-cli-macos-arm64-2026.02.02-093032.tar.gz"
    sha256 "bd9331cc1d4bf3e5094fc8685577a1016356b1443a77508a5d6ecb9a00481c20"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.02.02-093032/wendy-cli-linux-static-musl-aarch64-2026.02.02-093032.tar.gz"
      sha256 "ca832fcd9b0a8f2e64b6f1b6110c8ba21e083a6c462cc3f605b46c47eee63999"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.02.02-093032/wendy-cli-linux-static-musl-x86_64-2026.02.02-093032.tar.gz"
      sha256 "41ac9514a56208e50c6088f5d814d1873a516d847506aa4523c4a318d78efb0b"
    end
  end

  def install
    # Install pre-built binaries (all platforms)
    bin.install "wendy"
    bin.install "wendy-helper" if File.exist?("wendy-helper")
    bin.install "wendy-network-daemon" if File.exist?("wendy-network-daemon")

    # Install macOS-specific bundle with resources (plist files, etc) if present
    bundle_path = "wendy-agent_wendy.bundle"
    (lib/"wendy").install bundle_path if File.directory?(bundle_path)
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
    assert_match "OVERVIEW: Wendy CLI", shell_output("#{bin}/wendy --help")
  end
end
