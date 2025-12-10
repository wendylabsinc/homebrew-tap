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
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.12.10-213551/wendy-cli-macos-arm64-2025.12.10-213551.tar.gz"
    sha256 "4d4dd41df062080111ff0fdac5d8318b0899521b70f1a62bcd38c4b101433d43"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.12.10-213551/wendy-cli-linux-static-musl-aarch64-2025.12.10-213551.tar.gz"
      sha256 "a471357f4582f84df97cbe25e4e08d605a26f3e78e71ac268179677bf71142fa"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.12.10-213551/wendy-cli-linux-static-musl-x86_64-2025.12.10-213551.tar.gz"
      sha256 "3f41aec3676c257d1fd9bf59583f46dc031b46754fcaf49fcb39bee9c9d1df21"
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
