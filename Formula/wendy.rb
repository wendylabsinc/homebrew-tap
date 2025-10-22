class Edge < Formula
  desc "CLI for building and running WenyOS applications"
  homepage "https://github.com/wendylabsinc/wendy-agent"
  license "Apache-2.0"
  head "https://github.com/wendylabsinc/wendy-agent.git", branch: "main"

  # Use source tarball for macOS (needs to build from source)
  on_macos do
    url "https://github.com/wendylabsinc/wendy-agent/archive/refs/tags/2025.10.18-100500.tar.gz"
    sha256 "e5fc8d04aa11a96ed36441424622379c542274aa44e9d2969884e2d73b174809"
  end

  # Use pre-built binaries for Linux
  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.10.18-100500/wendy-cli-linux-static-musl-aarch64.tar.gz"
      sha256 "2aa5fcf49ee3cb0e1f53f6affc84e0d696ba6a73075b4667904db134873ff13e"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.10.18-100500/wendy-cli-linux-static-musl-x86_64.tar.gz"
      sha256 "413f0c08af374c3ee14566c73965ff098ce838e1cdff1d0b3b07825a53507093"
    end
  end

  depends_on xcode: [">= 16.3", :build] if OS.mac?
  depends_on "pv" if OS.mac?
  depends_on "swiftly" # For managing Swift toolchains (kept after install)

  uses_from_macos "swift" => :build

  def install
    if OS.mac?
      # macOS: Build from source
      system "./Scripts/inject-version.sh", version.to_s

      # Optionally use Swiftly if available and already configured
      # Skip in CI or sandboxed environments to avoid permission issues
      if File.exist?(".swift-version") && ENV["HOMEBREW_SANDBOX"].nil?
        swift_version = File.read(".swift-version").strip

        # Check if Swiftly is already initialized
        config_path = "#{Dir.home}/.swiftly/config.json"

        if which("swiftly") && File.exist?(config_path)
          ohai "Using Swiftly to install Swift #{swift_version}..."
          system "swiftly", "install", swift_version
          system "swiftly", "use", swift_version

          # Update PATH to use swiftly's Swift
          swiftly_bin = "#{Dir.home}/Library/Developer/Toolchains/swift-#{swift_version}.xctoolchain/usr/bin"
          ENV.prepend_path "PATH", swiftly_bin if File.directory?(swiftly_bin)
        end
      end

      system "swift", "build", "--disable-sandbox", "-c", "release", "--product", "wendy"
      bin.install ".build/release/wendy"

      # Install macOS-specific bundle with resources (plist files, etc)
      bundle_path = ".build/release/wendy-agent_wendy.bundle"
      (lib/"wendy").install bundle_path if File.directory?(bundle_path)
    else
      # Linux: Use pre-built binary
      bin.install "wendy"
    end
  end

  test do
    # TODO: It would be better to actually build something, instead of just checking the help text.
    system bin/"wendy", "--help"
    assert_match "OVERVIEW: Wendy CLI", shell_output("#{bin}/wendy --help")
  end
end
