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
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.01.16-234242/wendy-cli-macos-arm64-2026.01.16-234242.tar.gz"
    sha256 "96011159f7c92739310d631ca05ddaf65c584dd94ce2d393ef61a160634ac948"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.01.16-234242/wendy-cli-linux-static-musl-aarch64-2026.01.16-234242.tar.gz"
      sha256 "b044bba7fbf85770bec21b99357a217179aa3f4391759ba7d3cca165ee74203f"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.01.16-234242/wendy-cli-linux-static-musl-x86_64-2026.01.16-234242.tar.gz"
      sha256 "30295dec515bafdaefd67491beeaf768fb858f20ac3ae1f2b3780aaf50920c96"
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
