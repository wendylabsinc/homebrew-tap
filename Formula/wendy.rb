class Wendy < Formula
  desc "CLI for building and running WendyOS applications"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-2025.10.30-183638"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "48314eafc28175a010eb2c7f1ff97dcfca84977bd8856ad3873d6099bd003251"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.10.30-220923/wendy-cli-macos-arm64-2025.10.30-220923.tar.gz"
    sha256 "f700ac702b6153c24cadae4025b3d5670aca4e32fe5bc9826dadd79205e26b16"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.10.30-220923/wendy-cli-linux-static-musl-aarch64-2025.10.30-220923.tar.gz"
      sha256 "36d8f0896bb007734244990ab6a9c51a1997ce4a63633e4f4c1374da32f4ce02"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.10.30-220923/wendy-cli-linux-static-musl-x86_64-2025.10.30-220923.tar.gz"
      sha256 "a1edc28f141212eb41ec28583493961b4749bbe1cdb1e088ef8dba07f1c8d61d"
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
