class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.03.16-022724"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "8d522b41096d04b20e95a0976d84b6b216811e609e3fd6c6c8ab70dcf3260da8"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.16-022724/wendy-cli-darwin-arm64-2026.03.16-022724.tar.gz"
    sha256 "c7a1f69a3abf4ee6df8bd6189260de04efa1d4b55ba5d329736ad9eea78ff936"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.16-022724/wendy-cli-linux-arm64-2026.03.16-022724.tar.gz"
      sha256 "1c78eb886ed8767633803e805883296e09fc12176c6965b03dc3d7305e945eca"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.16-022724/wendy-cli-linux-amd64-2026.03.16-022724.tar.gz"
      sha256 "cb2d53b4e4d3fa104d9489ca39b7125b134b0cb311977216d9700b8832a879e7"
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
