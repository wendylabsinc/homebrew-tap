class Wendy < Formula
  desc "CLI for building and running WendyOS applications"
  homepage "https://github.com/wendylabsinc/wendy-agent"
  version "2025.10.22-190204"

  # Use source tarball for macOS (needs to build from source)
  on_macos do
    url "https://github.com/wendylabsinc/wendy-agent/archive/refs/tags/2025.10.22-190204.tar.gz"
    sha256 "958c968e755fa810f863aabfe3af923a384a1ad6bc0c40b107def7539525ff5f"
  end

  # Use pre-built binaries for Linux
  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.10.22-190204/wendy-cli-linux-static-musl-aarch64.tar.gz"
      sha256 "b969fef8e20d0bc2141e7729a3482a98c8aefe6824f3ef2a498fa119d0a31bca"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.10.22-190204/wendy-cli-linux-static-musl-x86_64.tar.gz"
      sha256 "61d0db102cc4d0c98fb29120e2f1425d6d3af7b9ce9edd657c95ae32512396d7"
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
