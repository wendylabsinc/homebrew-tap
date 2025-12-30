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
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.12.30-063131/wendy-cli-macos-arm64-2025.12.30-063131.tar.gz"
    sha256 "78aec9c4fa4bd72022b493a44f7c03f9a134cb8e911186f35f708297a4968cbb"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.12.30-063131/wendy-cli-linux-static-musl-aarch64-2025.12.30-063131.tar.gz"
      sha256 "a16a5e487b4efe5d01a3edf80f70fba2355657ffc9067971e1d5558a195f9589"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.12.30-063131/wendy-cli-linux-static-musl-x86_64-2025.12.30-063131.tar.gz"
      sha256 "884b36eb36bb3da06f79a552151958cf7e7b9368c0a255a978170d6c527c0310"
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
