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
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.11.09-122010/wendy-cli-macos-arm64-2025.11.09-122010.tar.gz"
    sha256 "9ffddfd4c698b07ab0032578d0420a57849b32723abc2f3d5c93fd2604a7c890"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.11.09-122010/wendy-cli-linux-static-musl-aarch64-2025.11.09-122010.tar.gz"
      sha256 "c6c82375ae7a1a97deef76646344131275526c807dceeb27166bd62ae21f4386"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.11.09-122010/wendy-cli-linux-static-musl-x86_64-2025.11.09-122010.tar.gz"
      sha256 "78b8aac70e543513a1f339fa216402a93ce7c8e3ea8c68c22e33b14243b8a05f"
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
