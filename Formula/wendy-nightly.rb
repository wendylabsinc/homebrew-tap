class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.03.10-130047"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "1c555b730017831b880826241ab354d17837a923a286d3b44b0d663eae127eac"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.10-130047/wendy-cli-darwin-arm64-2026.03.10-130047.tar.gz"
    sha256 "e79dcc6e5e5328ae596ebc207908ab9606098910af309ace4a12bf3f6eb06603"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.10-130047/wendy-cli-linux-arm64-2026.03.10-130047.tar.gz"
      sha256 "b1bf38e735fbfe2eb685a596c7a16607008860a7def3ea56e4900b27110ea0d4"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.10-130047/wendy-cli-linux-amd64-2026.03.10-130047.tar.gz"
      sha256 "fccccecb5db8989224492668e50374bcf711d184d75d58173d2b16401a782078"
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
