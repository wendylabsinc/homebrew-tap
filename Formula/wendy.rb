class Wendy < Formula
  desc "CLI for building and running WendyOS applications"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-2026.03.15-174759"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "fb36174bf22ce0640ba0860a7f4d7cd228ac2c4f02c658710db3b4d679bcbb84"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.15-174759/wendy-cli-darwin-arm64-2026.03.15-174759.tar.gz"
    sha256 "cd0438e5f4e536acba680e470984e2553194a9613ee1ae2c1c354dac1b631ab8"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.15-174759/wendy-cli-linux-arm64-2026.03.15-174759.tar.gz"
      sha256 "da383f310776efea90e2673a51c5d27ccc01ca66f027ed8da27f1bd7c1cdeff5"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.15-174759/wendy-cli-linux-amd64-2026.03.15-174759.tar.gz"
      sha256 "0ab6b3d6f73114925fd51d726dbbc53c29d67caf00ae3e2c7e153cd55b17fe68"
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
