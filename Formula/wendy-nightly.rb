class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.04.24-094128"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "bba9282ea6609544747d22050d02cea919d10d44210628d5912db41d85ae0314"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.24-094128/wendy-cli-darwin-arm64-2026.04.24-094128.tar.gz"
    sha256 "acc6a04f5a50163960757fcc90db8f376a41b95d12da6205f6c4b8e543c425b8"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.24-094128/wendy-cli-linux-arm64-2026.04.24-094128.tar.gz"
      sha256 "23240b21b003f3128900694ff807be67386569411aaf9d97193815c0ab40087f"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.24-094128/wendy-cli-linux-amd64-2026.04.24-094128.tar.gz"
      sha256 "bdbd600967e3780d75e90e650ac4e7f53027d5948a037f7eb8936aab47348b4e"
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
