class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.06.09-102117"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "84ce3c2f00da007fe4c3b7262db3893c6ffb7bf31281e2099e56f748b7432623"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.09-102117/wendy-cli-darwin-arm64-2026.06.09-102117.tar.gz"
    sha256 "a9962f3b3e26a67365e6e7528e0c1a856211f2b4be540330b56e23296ed0c655"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.09-102117/wendy-cli-linux-arm64-2026.06.09-102117.tar.gz"
      sha256 "c6eacff079378131b697087218a5d37d49a568d7e72fc1e66852b77de43002ca"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.06.09-102117/wendy-cli-linux-amd64-2026.06.09-102117.tar.gz"
      sha256 "7592c64dbfeacfa539a830e3329284cb19ad73daaab790ef08e3378f2e27852f"
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
