class Wendy < Formula
  desc "CLI for building and running WendyOS applications"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-2026.04.02-195951"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "b264ed4a25fd4609f51fbfdeb83950f327dee32cfbfc3a41063ca4a2b8e0de99"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.02-195951/wendy-cli-darwin-arm64-2026.04.02-195951.tar.gz"
    sha256 "61008dda002de057f53a6e1103ff8553e4191be04d895e0a836f0e62fe784fa2"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.02-195951/wendy-cli-linux-arm64-2026.04.02-195951.tar.gz"
      sha256 "ac9da50058c9f7319017fc3cb45af99631df35e4d99c5cf73735cae5b28458b5"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.02-195951/wendy-cli-linux-amd64-2026.04.02-195951.tar.gz"
      sha256 "57ad2330d18086e48b9c05aeae484ea91e01b9e999a9d5fefa6584c9e862f536"
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
