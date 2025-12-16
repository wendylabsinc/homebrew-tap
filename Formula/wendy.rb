class Wendy < Formula
  desc "CLI for building and running WendyOS applications"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-2025.12.15-163638"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "1dc073206837862a6145c40271de6c0735a966eedd9f56d0b14d04c2267f1093"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.12.15-163638/wendy-cli-macos-arm64-2025.12.15-163638.tar.gz"
    sha256 "69ae9c819cfa13690f7e385cb24a3cf8a5fb27e830687df4cb4fdb15ae202218"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.12.15-163638/wendy-cli-linux-static-musl-aarch64-2025.12.15-163638.tar.gz"
      sha256 "cae329c0440f19cd14bc0dac0945b31210aca90d3d454bfa8428e34d40c48627"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.12.15-163638/wendy-cli-linux-static-musl-x86_64-2025.12.15-163638.tar.gz"
      sha256 "441827f411ee6703b8f2378542208a1e15711704da265e7d957fdb1938a5a39d"
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
