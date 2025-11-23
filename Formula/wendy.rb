class Wendy < Formula
  desc "CLI for building and running WendyOS applications"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-2025.11.20-123048"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "960b04a9aa1b193581b3e3fd149ef190260b5b3a647f1c381c5d8e7ee3f5b921"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.11.23-193145/wendy-cli-macos-arm64-2025.11.23-193145.tar.gz"
    sha256 "ac4edb681f2af6e4d9e180ac17b7e09ce66971fd068d32e517136b85d83178e6"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.11.23-193145/wendy-cli-linux-static-musl-aarch64-2025.11.23-193145.tar.gz"
      sha256 "24aa49f6796668b629e32a7e04262f76842c7260e4e6ab9bb459a1871bbe888f"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.11.23-193145/wendy-cli-linux-static-musl-x86_64-2025.11.23-193145.tar.gz"
      sha256 "e5385c878b41f90d1e6ac8e530b5e70868b1bedc100e3244b2879cbf600de498"
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
