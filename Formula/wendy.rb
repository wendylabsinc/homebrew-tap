class Wendy < Formula
  desc "CLI for building and running WendyOS applications"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-2026.03.12-200352"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "e7ff5b8cd8d0c35e2a835e9e52f23b5718938c5666de9e8873404aa2f74e0237"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.12-200352/wendy-cli-darwin-arm64-2026.03.12-200352.tar.gz"
    sha256 "4eca4ff021fbc0135a026017ba0bafd6670ec9ab4ab7a5fd0ce5ecff0d6f4a53"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.12-200352/wendy-cli-linux-arm64-2026.03.12-200352.tar.gz"
      sha256 "2b446fe9aaac4eaf14a704125a73529f8c05eb66df13c84dd903f9f1fac80a9c"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.12-200352/wendy-cli-linux-amd64-2026.03.12-200352.tar.gz"
      sha256 "206531f3fa3afb1735c35e754329a836200c8178aa3ec8c569eb363f12500f90"
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
