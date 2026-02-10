class Wendy < Formula
  desc "CLI for building and running WendyOS applications"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-2026.02.06-150016"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "b867749ccdd7bf9d9cd7f6927c7e24dd2cdecb6da354bc934c5884268cd3793e"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.02.10-160751/wendy-cli-macos-arm64-2026.02.10-160751.tar.gz"
    sha256 "50bd1a787aa1df92d3320ce25237305a03a4f9f4d32d45c248d35c9d1886bcfa"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.02.10-160751/wendy-cli-linux-static-musl-aarch64-2026.02.10-160751.tar.gz"
      sha256 "1a8eecb62aa1105175c14f0028a2ea6eaba2706e9ce9c4add432d9c4d685d2b7"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.02.10-160751/wendy-cli-linux-static-musl-x86_64-2026.02.10-160751.tar.gz"
      sha256 "9a77cce4fe612ec33e5450dbe14c855383588eee0da4d7e232a68b5890788aa8"
    end
  end

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
