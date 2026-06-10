class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.06.10-192651"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "95518af14380eba59b3ef05f7984a3f31a2459aed34fa972d011832eebf75a47"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.10-192651/wendy-cli-darwin-arm64-2026.06.10-192651.tar.gz"
    sha256 "4319e28a30a4dd4bccadbb5b60730bbb6f414c3a61e471b29efdc00dd30b9e3f"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.10-192651/wendy-cli-linux-arm64-2026.06.10-192651.tar.gz"
      sha256 "5db31c27d133b4b99d5f45edefa5b191e38bb6faa8ef5ae843f189d73de1bbfb"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.10-192651/wendy-cli-linux-amd64-2026.06.10-192651.tar.gz"
      sha256 "ffdaede23d377468e03a72221d30043d8cdfc4636ec6c63e213907ffe545d2ba"
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

  def post_install
    quiet_system bin/"wendy", "completion", "install"
  end

  def caveats
    <<~EOS
      Attention: The Wendy CLI collects anonymous analytics.
      They help us understand which commands are used most, identify common errors, and prioritize improvements.
      Analytics are enabled by default. If you'd like to opt-out, use the following command:
        wendy analytics disable
      Or, set the following environment variable:
        WENDY_ANALYTICS=false

      To set up MCP integration with your AI tools:
        wendy mcp setup
    EOS
  end

  test do
    system bin/"wendy", "--help"
    assert_match "wendy [command]", shell_output("#{bin}/wendy --help")
  end
end
