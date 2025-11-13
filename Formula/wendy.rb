class Wendy < Formula
  desc "CLI for building and running WendyOS applications"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-2025.11.09-122010"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "99c2df5c95e4579fc3fca357b62e6039441bd463d0b2a70e1aeb1850cac00ccf"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.11.13-191143/wendy-cli-macos-arm64-2025.11.13-191143.tar.gz"
    sha256 "1124695e9563e487626099f59214ba5a7b70afe7dc04e735a8326f98bbee94a6"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.11.13-191143/wendy-cli-linux-static-musl-aarch64-2025.11.13-191143.tar.gz"
      sha256 "c0284f8d920e947b38802c4e22f6954f4ceca0c09814c79adb222f6e646fdfe2"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.11.13-191143/wendy-cli-linux-static-musl-x86_64-2025.11.13-191143.tar.gz"
      sha256 "f67eed11e34155a02c9b032a2e1bb3b42b3870062522674e055bc7ada56530c1"
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

  test do
    # TODO: It would be better to actually build something, instead of just checking the help text.
    system bin/"wendy", "--help"
    assert_match "OVERVIEW: Wendy CLI", shell_output("#{bin}/wendy --help")
  end
end
