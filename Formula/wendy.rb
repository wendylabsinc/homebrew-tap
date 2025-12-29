class Wendy < Formula
  desc "CLI for building and running WendyOS applications"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-2025.12.26-211420"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "7236a081f3f11d311096e7906274cf4ec7ec0135ad2f953a70b595ea449964b9"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.12.29-103149/wendy-cli-macos-arm64-2025.12.29-103149.tar.gz"
    sha256 "a48830466fa10b53790505e4b301e49cfa110b8c88798ec18dd736d6a779e1f2"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.12.29-103149/wendy-cli-linux-static-musl-aarch64-2025.12.29-103149.tar.gz"
      sha256 "987d0826ac787109c2a851cd5935acae7410d8eefdcfd9b759b48cf43fb0dfb4"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.12.29-103149/wendy-cli-linux-static-musl-x86_64-2025.12.29-103149.tar.gz"
      sha256 "5a8544d5d88a20d2509c58c176c3990d1e780cb882df6eb3865008196a8f3a59"
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
