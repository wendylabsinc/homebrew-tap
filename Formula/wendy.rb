class Wendy < Formula
  desc "CLI for building and running WendyOS applications"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-2025.11.07-153355"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "ae546439579db310fa50500a7da10fb8cb500ed9e858a70285bb3fe52f9ede16"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.11.08-130612/wendy-cli-macos-arm64-2025.11.08-130612.tar.gz"
    sha256 "82843abdb5962b617aa8997d775c8eefed3eb87f13a00bf4dced80a60e6ff5e9"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.11.08-130612/wendy-cli-linux-static-musl-aarch64-2025.11.08-130612.tar.gz"
      sha256 "551c7ed97be9f4eb73dd2f06730795d1438b70e045098799a245f56ba2beaf46"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.11.08-130612/wendy-cli-linux-static-musl-x86_64-2025.11.08-130612.tar.gz"
      sha256 "f87d9dc8c906d4aa5bcea0905b06b36aadc1d576a9aebaa67ed94e5482f40ce6"
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
