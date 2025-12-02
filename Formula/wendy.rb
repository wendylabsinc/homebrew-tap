class Wendy < Formula
  desc "CLI for building and running WendyOS applications"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-2025.12.01-191725"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "564d7fff7808e0ce63d8dee7e3a6c8aa81a1091032db80348757ab8fdb9d9493"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.12.02-173049/wendy-cli-macos-arm64-2025.12.02-173049.tar.gz"
    sha256 "6557452163f65cbec02d9159f24002b61aaa9572b33b8d57c07e91606e37959e"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.12.02-173049/wendy-cli-linux-static-musl-aarch64-2025.12.02-173049.tar.gz"
      sha256 "491fa341ee6eb04e7b37a15f9cd4da726a5cd2010b4c941affe96eec7ce9e08f"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.12.02-173049/wendy-cli-linux-static-musl-x86_64-2025.12.02-173049.tar.gz"
      sha256 "f1a5f7dc3617573a93569ab16db2dc3310d174b407e211bb8e947f6b01711a5b"
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
