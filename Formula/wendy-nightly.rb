class WendyNightly < Formula
  desc "CLI for building and running WendyOS applications (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  bottle do
    root_url "https://github.com/wendylabsinc/homebrew-tap/releases/download/wendy-nightly-2026.05.02-142249"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "57a206ba803378fc00b1d3ed6590087c54c718da1b7b4ded4cca3129990c9258"
  end

  # Use pre-built binaries for all platforms
  if OS.mac?
    # macOS ARM64 only (signed and notarized)
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.05.02-142249/wendy-cli-darwin-arm64-2026.05.02-142249.tar.gz"
    sha256 "954124ca612115b24ea2007c4cfcb8dbd9f300a7264f372cfc3c19e6e93a9996"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.05.02-142249/wendy-cli-linux-arm64-2026.05.02-142249.tar.gz"
      sha256 "64335b13c4756f64b1bf1f3189ea107228678b49fd3ed11a138dac22e5fd2871"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2026.05.02-142249/wendy-cli-linux-amd64-2026.05.02-142249.tar.gz"
      sha256 "37e549619000b809f8068a14aa630156afb43adf7aa45e75e700545d0768d393"
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
