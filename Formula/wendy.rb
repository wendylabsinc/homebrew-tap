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
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.12.02-175042/wendy-cli-macos-arm64-2025.12.02-175042.tar.gz"
    sha256 "39d6c146f7eb82c56d9bdcf84fb9931d587f415099f0a37df5ee634ce21894fe"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.12.02-175042/wendy-cli-linux-static-musl-aarch64-2025.12.02-175042.tar.gz"
      sha256 "f8cc57f396354a54b0c20955d3748d16740a7a413531e0e7e6ff6b8f89d279be"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.12.02-175042/wendy-cli-linux-static-musl-x86_64-2025.12.02-175042.tar.gz"
      sha256 "0d21eebd338e0cca17c30b08af2a53aa62258a460a8f49795820b208c7735c0c"
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
