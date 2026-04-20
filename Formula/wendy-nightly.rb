class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.04.20-063347"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "482a3d288ce421da9d102c8458ec7fdf0d6c8b760eca4d1826c25c4310796629"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.20-063347/wendy-cli-darwin-arm64-2026.04.20-063347.tar.gz"
    sha256 "6ed91edcff4c58fcca995ae3a730cca46298edebd109cbd876197155802e4c09"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.20-063347/wendy-cli-linux-arm64-2026.04.20-063347.tar.gz"
      sha256 "1dba6101a44136882a63622633ed1868fa7c371b924cced0bbf970441671db72"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.04.20-063347/wendy-cli-linux-amd64-2026.04.20-063347.tar.gz"
      sha256 "431de75d8b8063be1e62b06ac4237bc434f00f7287ed0312620c1c13ae5f6918"
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
