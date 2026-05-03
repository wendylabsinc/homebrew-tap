class Wendy < Formula
  desc "CLI for building and running WendyOS applications"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-2026.05.03-215349"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "96ba04fbff4e703f46a0c992ccb0a7c25382935cbba49886a0914d9a885dd709"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.05.03-215349/wendy-cli-darwin-arm64-2026.05.03-215349.tar.gz"
    sha256 "74e77f6e181c2e419719024aec4720f7dfa16c965fc893c207a04a9e63b93e18"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.05.03-215349/wendy-cli-linux-arm64-2026.05.03-215349.tar.gz"
      sha256 "1fd2ad9d79e366f3e4adc810ef8586baae1774afab6dda46155e969d3488e2c4"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.05.03-215349/wendy-cli-linux-amd64-2026.05.03-215349.tar.gz"
      sha256 "34ed871e4814ad32b31f872ebf5bb5d764e9c9a5b15da69b6f9c84ffbe4716d5"
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
