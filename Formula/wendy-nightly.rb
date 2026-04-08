class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.04.08-193400"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "15c278538943fd870a32f6cd00d12a41bdee950bb9b8bd3f21bf9b60bacb97dc"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.08-193400/wendy-cli-darwin-arm64-2026.04.08-193400.tar.gz"
    sha256 "1d367feda6bb40c389be106a7978200d9cbff7c532519f52f359b67ca44bd05f"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.08-193400/wendy-cli-linux-arm64-2026.04.08-193400.tar.gz"
      sha256 "18f3bd998829b716a13682da2563930d03a1b37332ade6a1ac1db7e43d5510cb"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.08-193400/wendy-cli-linux-amd64-2026.04.08-193400.tar.gz"
      sha256 "8ca5fcbb81f3885108e32ad385a25fa376134ea22bec0542227daa870ab0c890"
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
