class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.04.10-163444"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "624e6c95b9ce40373bf396c3b7ef800615d3007c70c8fa7952dbe9ea16726ed0"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.10-163444/wendy-cli-darwin-arm64-2026.04.10-163444.tar.gz"
    sha256 "b4c644b1e7dc42a6affeb81dcecd08d3664c3754c53ef6a4defe9845b0535aeb"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.10-163444/wendy-cli-linux-arm64-2026.04.10-163444.tar.gz"
      sha256 "62d087c750fe83e8269a477bc0143ef7519eb48fef13d779edd253ee17aa1de5"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.10-163444/wendy-cli-linux-amd64-2026.04.10-163444.tar.gz"
      sha256 "2f7a3e838db9983f8391e4748727ef70c252277be588f988e919776d010f6e2b"
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
