class Edge < Formula
  desc "CLI for building and running Edge applications"
  homepage "https://github.com/edgeengineer/edge-agent"
  license "Apache-2.0"
  head "https://github.com/edgeengineer/edge-agent.git", branch: "main"
  
  # Use source tarball for macOS (needs to build from source)
  on_macos do
    url "https://github.com/edgeengineer/edge-agent/archive/refs/tags/2025.09.17-225954.tar.gz"
    sha256 "6bab77a94706cf7e8976fef49789caa6fee687768f4008fe7cbfd732eb967b5d"
  end
  
  # Use pre-built binaries for Linux
  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/edgeengineer/edge-agent/releases/download/2025.09.17-225954/edge-cli-linux-static-musl-aarch64.tar.gz"
      sha256 "f448b3f01d2b193300db347adeffbed7bfef32272b9614442e77e1a5e5d4d3e6"
    else
      url "https://github.com/edgeengineer/edge-agent/releases/download/2025.09.17-225954/edge-cli-linux-static-musl-x86_64.tar.gz"
      sha256 "484084be95b073c613c435503bbfc6cdfc7bae945744846cf10cc863bd7d05fb"
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

      system "swift", "build", "--disable-sandbox", "-c", "release", "--product", "edge"
      bin.install ".build/release/edge"

      # Install macOS-specific bundle with resources (plist files, etc)
      bundle_path = ".build/release/edge-agent_edge.bundle"
      (lib/"edge").install bundle_path if File.directory?(bundle_path)
    else
      # Linux: Use pre-built binary
      bin.install "edge"
    end
  end

  test do
    # TODO: It would be better to actually build something, instead of just checking the help text.
    system bin/"edge", "--help"
    assert_match "OVERVIEW: Edge CLI", shell_output("#{bin}/edge --help")
  end
end
