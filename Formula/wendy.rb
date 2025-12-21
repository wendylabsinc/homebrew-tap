class Wendy < Formula
  desc "CLI for building and running WendyOS applications"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-2025.12.15-163638"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "1dc073206837862a6145c40271de6c0735a966eedd9f56d0b14d04c2267f1093"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.12.21-091451/wendy-cli-macos-arm64-2025.12.21-091451.tar.gz"
    sha256 "72056f90a656d512ce58a94a6ba2addf7ba12c3263870c700e35fcc91b4d23df"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.12.21-091451/wendy-cli-linux-static-musl-aarch64-2025.12.21-091451.tar.gz"
      sha256 "27861c3adeebd9b0e64f5381d9a36c55e077d70eac98c6855905f98b1d6a490c"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.12.21-091451/wendy-cli-linux-static-musl-x86_64-2025.12.21-091451.tar.gz"
      sha256 "9da6e0672b248c58dc40f44d6bcc329f730d36e2c5f5237e8dccfa01987a2884"
    end
  end

  def install
    # Install pre-built binaries (all platforms)
    bin.install "wendy"
    bin.install "wendy-helper" if File.exist?("wendy-helper")
    bin.install "wendy-network-daemon" if File.exist?("wendy-network-daemon")

    # Install macOS-specific bundle with resources (plist files, etc) if present
    bundle_path = "wendy-agent_wendy.bundle"
    (lib/"wendy").install bundle_path if File.directory?(bundle_path)
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
    assert_match "OVERVIEW: Wendy CLI", shell_output("#{bin}/wendy --help")
  end
end
