class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.05.02-025508"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "f22d566699b72ffcfb5cc6fe3bb66b63f77e2ab734cc3484dee968bc4067a4cf"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.05.02-025508/wendy-cli-darwin-arm64-2026.05.02-025508.tar.gz"
    sha256 "4d9acb27220b7e6f0664d59a3f8e57476cb5f2ae6be0bfafe54d8ca4d47a3b32"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.05.02-025508/wendy-cli-linux-arm64-2026.05.02-025508.tar.gz"
      sha256 "cfe997bb26c65a047362b8af2e5fb1a5958de8624f558b9584856f35985c3ff2"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.05.02-025508/wendy-cli-linux-amd64-2026.05.02-025508.tar.gz"
      sha256 "16e3f06313d5ec6b6c8a9b9d4c5512af9e7e759880dc796aa4cc3c066411b1e2"
    end
  end

  conflicts_with "wendy", because: "both install a `wendy` binary"

  def install
    # Install pre-built binaries (all platforms)
    bin.install "wendy"
    bin.install "wendy-helper" if File.exist?("wendy-helper")
    bin.install "wendy-network-daemon" if File.exist?("wendy-network-daemon")

    # Install macOS-specific bundle with resources (plist files, etc) if present
    bundle_path = "wendy-agent_wendy.bundle"
    (lib/"wendy").install bundle_path if File.directory?(bundle_path)

    # Generate and install shell completions
    generate_completions_from_executable(bin/"wendy", "completion")
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
    system bin/"wendy", "--help"
    assert_match "OVERVIEW: Wendy CLI", shell_output("#{bin}/wendy --help")
  end
end
