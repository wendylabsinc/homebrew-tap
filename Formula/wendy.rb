class Wendy < Formula
  desc "CLI for building and running WendyOS applications"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-2025.11.05-201652"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "6f9493ca466719fb4ec110bbdf68858cf85a8e8667306a56050f1d63e6dcb908"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.11.05-201652/wendy-cli-macos-arm64-2025.11.05-201652.tar.gz"
    sha256 "bb835be98f8a0d210675b695ee441df962ed7644add4cc3f6a798228da8908ea"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.11.05-201652/wendy-cli-linux-static-musl-aarch64-2025.11.05-201652.tar.gz"
      sha256 "d9b70161b8b4306a0adbf1eabff4f1cb33e8a99b15d4e57e3adb0ae103447ba4"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.11.05-201652/wendy-cli-linux-static-musl-x86_64-2025.11.05-201652.tar.gz"
      sha256 "8eaa9158d3102fd936804671b4312693da87ba2f61f8bc7c4fd89330256f6d7e"
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
