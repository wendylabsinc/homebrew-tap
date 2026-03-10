class Wendy < Formula
  desc "CLI for building and running WendyOS applications"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-0.2.1"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "91ebd633a224c60973cf60aa06508b53f15ed02a9eef5cc906662ef41c34b721"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.02.06-150016/wendy-cli-macos-arm64-2026.02.06-150016.tar.gz"
    sha256 "49176fd12e191306b6c74059468046e3b53d030281d2356745886ff370488507"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.02.06-150016/wendy-cli-linux-static-musl-aarch64-2026.02.06-150016.tar.gz"
      sha256 "ea8cbc4861dc8513531454bddade96bda77718cc55421dedfa5f2b8628e213c5"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.02.06-150016/wendy-cli-linux-static-musl-x86_64-2026.02.06-150016.tar.gz"
      sha256 "fccf636df6007499b2f956f2d1ac9a9dae4a6d97636633198e7434b8d2a25353"
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
    generate_completions_from_executable(bin/"wendy", "--generate-completion-script")
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
    assert_match "OVERVIEW: Wendy CLI", shell_output("#{bin}/wendy --help")
  end
end
