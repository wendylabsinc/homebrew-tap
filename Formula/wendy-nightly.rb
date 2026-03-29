class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.03.29-183847"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "1a16cacc9f5e21b563ffa403ff3730c3d3dedb801f290bfa6bd8a0be0c91a4d0"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.29-183847/wendy-cli-darwin-arm64-2026.03.29-183847.tar.gz"
    sha256 "aa10e9a67dd777f8bb5b85b474abb28b39c4a4b336e5cd7ca875ddcba55e708f"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.29-183847/wendy-cli-linux-arm64-2026.03.29-183847.tar.gz"
      sha256 "94b18b3fe47a949bee9d3c820c016179a1455e93a34276ac010fa03ee5932576"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.29-183847/wendy-cli-linux-amd64-2026.03.29-183847.tar.gz"
      sha256 "09717df429474e508b4bdd289d563bade0170b04f4dfbfd8ca4ce712178bd039"
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
