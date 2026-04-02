class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.04.02-204827"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "e91319fdd4e3afd836858f06e8dd4ce1c6830a901343513fd22c226b47771e28"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.02-204827/wendy-cli-darwin-arm64-2026.04.02-204827.tar.gz"
    sha256 "bb07cb0a2b5b325679a6f624c01f228592c8fa34c36f9554ed75f2aafffc8d6e"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.02-204827/wendy-cli-linux-arm64-2026.04.02-204827.tar.gz"
      sha256 "53a951e3645b867fcdb6ee0a9ac9d4fe8292376ee1579254a1ad670af9689db2"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.02-204827/wendy-cli-linux-amd64-2026.04.02-204827.tar.gz"
      sha256 "bfdd215becc7896f7ee4b335a711ba08a6c1b1811227bdd42459bf6e1b6c0d42"
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
