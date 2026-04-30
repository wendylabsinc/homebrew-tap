class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.04.30-152136"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "0c96747899d9851fd69dd04aa85f60976dd3624064efcfc869dab6dd0c68a4d6"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.30-152136/wendy-cli-darwin-arm64-2026.04.30-152136.tar.gz"
    sha256 "cf88c24babf4401884d298f7537b882cd03158559fd1081673f123ed36267bb7"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.30-152136/wendy-cli-linux-arm64-2026.04.30-152136.tar.gz"
      sha256 "e3e267837df75343e12d5a32d29afd4b0d476c95c9fb2ad9acb3cbbf34aa0a77"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.30-152136/wendy-cli-linux-amd64-2026.04.30-152136.tar.gz"
      sha256 "def37916045a3002bccbede129f54bdc123930c73dd2eecc7e0b6e7633e8b96f"
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
