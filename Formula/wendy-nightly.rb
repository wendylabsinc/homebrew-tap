class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.04.17-122941"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "b4c07339da99fba5883d66b6f86d39bd9c434986aeb37605f94d927e7d8b6f60"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.17-122941/wendy-cli-darwin-arm64-2026.04.17-122941.tar.gz"
    sha256 "42c2343e67fd0622f195f647a027232f4b8978f80813c60631c0473cf292169a"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.17-122941/wendy-cli-linux-arm64-2026.04.17-122941.tar.gz"
      sha256 "a98112ced03f53184726ea6636b8afc33f71f520eb29acbb99fb6a4394d9bef8"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.17-122941/wendy-cli-linux-amd64-2026.04.17-122941.tar.gz"
      sha256 "0ea174e27ae860e7991d8e04f2448fe0091e0072b6ab37cecd5fad3084d2cf47"
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
