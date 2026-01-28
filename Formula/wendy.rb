class Wendy < Formula
  desc "CLI for building and running WendyOS applications"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-2026.01.28-171806"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "e7570ec4d38b99be8ccf58232653af72e0caee251eef0f10bbf00582a74f5648"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.01.28-171806/wendy-cli-macos-arm64-2026.01.28-171806.tar.gz"
    sha256 "d638bdf917e2c391a798ca38f9ebbd461fba864a99629db826233ad0ab1b1438"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.01.28-171806/wendy-cli-linux-static-musl-aarch64-2026.01.28-171806.tar.gz"
      sha256 "9c014867ee7d3249b5f1ce74f79bad688cfbaa1f6d0b55e78acff0f8f518fdd3"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.01.28-171806/wendy-cli-linux-static-musl-x86_64-2026.01.28-171806.tar.gz"
      sha256 "3e79af483cf52d3aeb9ba2c4021eecea640e3314db89194534bd25c7a62d63ef"
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
