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
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.01.29-081448/wendy-cli-macos-arm64-2026.01.29-081448.tar.gz"
    sha256 "20ce74d36c28ab1e930f216514183f78f7fa953ace1845ca88ebdedcc3e22d46"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.01.29-081448/wendy-cli-linux-static-musl-aarch64-2026.01.29-081448.tar.gz"
      sha256 "2f6f0e09045493815f236c04856c2c6a074228f55678fe1bf2efc676fd363175"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.01.29-081448/wendy-cli-linux-static-musl-x86_64-2026.01.29-081448.tar.gz"
      sha256 "ce5945ade8706eedc4605ea5bcda521cf7d52d6f9bf85b546b99775a2ae9b4a5"
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
