class Wendy < Formula
  desc "CLI for building and running WendyOS applications"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-2025.10.30-175104"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "548cdb8ff71d74a4cb4f7029a5163dff659694f0b9980ad388e0478bc67687b1"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.10.30-183638/wendy-cli-macos-arm64-2025.10.30-183638.tar.gz"
    sha256 "72d1936a9a07c488f4ced6069bfd805da7d86a3e53d2cdd797cbc8bca16035b1"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.10.30-183638/wendy-cli-linux-static-musl-aarch64-2025.10.30-183638.tar.gz"
      sha256 "1d4d0d8af21e6cfec148cfb46c96e39b6afb9e87543f60c25fcbfa28d0c75907"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.10.30-183638/wendy-cli-linux-static-musl-x86_64-2025.10.30-183638.tar.gz"
      sha256 "c2283b93b76fb5f63c1bf6104a9bd7e8ea7f0943b7ef4009dd985153bf704429"
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
