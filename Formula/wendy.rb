class Wendy < Formula
  desc "CLI for building and running WendyOS applications"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-2026.03.16-163942"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "f141a140c6b5aea51950629f78ce46c0bb03e2c5bc1cde8f335d1d3791642fed"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.16-163942/wendy-cli-darwin-arm64-2026.03.16-163942.tar.gz"
    sha256 "78081ca2824c4e2b1fc5fe0730cda193c6f6f47a88c9426704ccf23accbbf1f6"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.16-163942/wendy-cli-linux-arm64-2026.03.16-163942.tar.gz"
      sha256 "c3dc32bed44d68711801d230063a62f7a4068aa581a1809e387c71f6a6a241c0"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.16-163942/wendy-cli-linux-amd64-2026.03.16-163942.tar.gz"
      sha256 "b3be06e024acd0c1c8b34d53e9da9f3d23243f4d9f577f147a5e1401baff9516"
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
