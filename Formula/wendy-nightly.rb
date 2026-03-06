class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.03.06-092719"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "a8643d5bf87b0bc9033e01e2e84b11f4381eba321360e6529bbec9ce3d76c7e9"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.06-092719/wendy-cli-darwin-arm64-2026.03.06-092719.tar.gz"
    sha256 "0b0156c6970fb84ab0e0de292b2100e7c9b5667d13a6d2b6ec80cd1ea7108e1f"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.06-092719/wendy-cli-linux-arm64-2026.03.06-092719.tar.gz"
      sha256 "e8ebf81eacc137d62ff4db7d6e3f0c62cae839025222daff4ae415f0cf1c7eb2"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.06-092719/wendy-cli-linux-amd64-2026.03.06-092719.tar.gz"
      sha256 "18b6c1f34d74aea06fbd3da16312a80b2b56906ecba505b06b221ce5fc454ca8"
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
