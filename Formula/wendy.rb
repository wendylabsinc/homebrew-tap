class Wendy < Formula
  desc "CLI for building and running WendyOS applications"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-2026.01.13-230914"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "636ae749daa56258672801b5c5993743c7a09a3f3dde5f937ac8c340fb09f899"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.01.26-234347/wendy-cli-macos-arm64-2026.01.26-234347.tar.gz"
    sha256 "88997acdb043a963408feb9f98b4efb59bb5fcd96df6c1e63c73c77aa1b9d60b"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.01.26-234347/wendy-cli-linux-static-musl-aarch64-2026.01.26-234347.tar.gz"
      sha256 "df55a35cf8a6c7bf533d06a3eda363fe8f587efa6534fee63d7aefd446f16bc6"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.01.26-234347/wendy-cli-linux-static-musl-x86_64-2026.01.26-234347.tar.gz"
      sha256 "9e1f46c510a586f1e2d12a6eda7f1a06f3e99ae994c07ff33db124319a70c83a"
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
