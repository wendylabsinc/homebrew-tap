class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.03.18-184247"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "e260dad191558948f1825246eba7627452c1c39a2fb2e9b7642c75f785b13a05"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.18-184247/wendy-cli-darwin-arm64-2026.03.18-184247.tar.gz"
    sha256 "5336b37834dafcd9732cb929389e42d8eea311ac29cb17a3ced9994fce0a90cb"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.18-184247/wendy-cli-linux-arm64-2026.03.18-184247.tar.gz"
      sha256 "a502f32b47a2baf9a32a16baa21710b78d4a810ac88684395d7696528a7b4809"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.18-184247/wendy-cli-linux-amd64-2026.03.18-184247.tar.gz"
      sha256 "d35ba58bd61b4598a379c58c91052f39428832d43dad45671d8ea3bff32eb766"
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
