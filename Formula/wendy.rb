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
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.12.12-181444/wendy-cli-macos-arm64-2025.12.12-181444.tar.gz"
    sha256 "472f8293b3357d3fa943ab84121bfc7c21e5ad52ffd78f61960d28aa48ab94c5"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.12.12-181444/wendy-cli-linux-static-musl-aarch64-2025.12.12-181444.tar.gz"
      sha256 "f5bab30efca70b1924a9bf338a856c804677ea7bd9723d4459427b22082962cb"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.12.12-181444/wendy-cli-linux-static-musl-x86_64-2025.12.12-181444.tar.gz"
      sha256 "470a74828de572e0cf306a88783096d81e886dfdd4e0806a4556dfb8223875e7"
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
