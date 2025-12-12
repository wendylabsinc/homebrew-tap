class Wendy < Formula
  desc "CLI for building and running WendyOS applications"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-2025.12.10-181918"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "699d601b0baa91b30e2c0b716a7f6f1d6642ace4f44798e121102c5fe1cd344a"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.12.11-234639/wendy-cli-macos-arm64-2025.12.11-234639.tar.gz"
    sha256 "67564a56202a3364a1851aca34a8aca8abfa3250aa804de212c90ecfad523f2b"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.12.11-234639/wendy-cli-linux-static-musl-aarch64-2025.12.11-234639.tar.gz"
      sha256 "1b36013f4b9013d1cf1c39a70e83fbe1fb152ecff935f541ee603ecdd90ffba0"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.12.11-234639/wendy-cli-linux-static-musl-x86_64-2025.12.11-234639.tar.gz"
      sha256 "0dbe0c7c9d8719beff1bf04e00a69e4b9ec3b5ca2e300651d3750c55be58812f"
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
