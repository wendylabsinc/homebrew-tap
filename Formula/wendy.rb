class Wendy < Formula
  desc "CLI for building and running WendyOS applications"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-2026.03.24-194126"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "948738dc6d2086f57cb8dc366a7e8ce672ce9c879c45cccaec1d46e217966b96"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.24-194126/wendy-cli-darwin-arm64-2026.03.24-194126.tar.gz"
    sha256 "f4a57d2a149ccf5d31779ef910b554392a9ef3fca8e015fbde4f7866f72b7aef"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.24-194126/wendy-cli-linux-arm64-2026.03.24-194126.tar.gz"
      sha256 "6daeffd47516322c6a0fcf529fd12382f334afd23d65aeff260c2eda0c7644cc"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.24-194126/wendy-cli-linux-amd64-2026.03.24-194126.tar.gz"
      sha256 "ffff89903aae7450bcb3d38e24fda1b6ae52a40c65ae336bc4614d24d5dd260d"
    end
  end

  conflicts_with "wendy-nightly", because: "both install a `wendy` binary"

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
    # TODO: It would be better to actually build something, instead of just checking the help text.
    system bin/"wendy", "--help"
    assert_match "wendy [command]", shell_output("#{bin}/wendy --help")
  end
end
