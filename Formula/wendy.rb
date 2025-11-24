class Wendy < Formula
  desc "CLI for building and running WendyOS applications"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-2025.11.24-205223"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "fdaa4ad355d283d154e68897569f12d6321ce4697c23d89740b7cfc7a986aefd"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.11.24-205223/wendy-cli-macos-arm64-2025.11.24-205223.tar.gz"
    sha256 "90ea5c0ccfe3c486aad8650a0f38990a84faeaeb67550f12345daf1b70670565"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.11.24-205223/wendy-cli-linux-static-musl-aarch64-2025.11.24-205223.tar.gz"
      sha256 "3d52c04ef73cd32ee930fdc5c9836fef94a59807d843b9535f6c7a3cda02cf17"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.11.24-205223/wendy-cli-linux-static-musl-x86_64-2025.11.24-205223.tar.gz"
      sha256 "0f792f51339f5c430e998be57ecf22e387a4c8dbc4ef256a8c15e4940e6bcd5d"
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
