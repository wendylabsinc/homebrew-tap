class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.03.11-102253"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "cf97ff6e406c0d8ea4f5f88be4e6823844240b7a93c1d6c137d9c72915c02ec3"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.11-102253/wendy-cli-darwin-arm64-2026.03.11-102253.tar.gz"
    sha256 "253bf275a3f65c997593764e83f346fe68a3d61ef66d602a77d0a678e0c801b5"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.11-102253/wendy-cli-linux-arm64-2026.03.11-102253.tar.gz"
      sha256 "226c592b774e08443da872992590281ea78c4591287d72c6bc2795d652550ac6"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.03.11-102253/wendy-cli-linux-amd64-2026.03.11-102253.tar.gz"
      sha256 "09cf48fd26a864ec778098ab356c8dfa2f6ff5340a9788fd69d6df43248d7251"
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
