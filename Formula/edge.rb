class Edge < Formula
  desc "CLI for building and running Edge applications"
  homepage "https://github.com/edgeengineer/edge-agent"
  url "https://github.com/edgeengineer/edge-agent/archive/refs/tags/2025.09.12-203653.tar.gz"
  sha256 "ac29b4da5a5b24a08e2b129fa60e3a31657d2f633d10819ab85fc636c7d76149"
  license "Apache-2.0"
  head "https://github.com/edgeengineer/edge-agent.git", branch: "main"

  depends_on xcode: ["16.3", :build] if OS.mac?
  depends_on "pv" if OS.mac?
  depends_on "swiftly" # For managing Swift toolchains (kept after install)

  uses_from_macos "swift" => :build
  uses_from_macos "tar"

  on_linux do
    depends_on "swift" => :build # Only for building, removed after
  end

  def install
    system "./Scripts/inject-version.sh", version.to_s

    # Optionally use Swiftly if available and already configured
    # Skip in CI or sandboxed environments to avoid permission issues
    if File.exist?(".swift-version") && ENV["HOMEBREW_SANDBOX"].nil?
      swift_version = File.read(".swift-version").strip

      # Check if Swiftly is already initialized
      config_path = if OS.mac?
        "#{Dir.home}/.swiftly/config.json"
      else
        "#{Dir.home}/.local/share/swiftly/config.json"
      end

      if which("swiftly") && File.exist?(config_path)
        ohai "Using Swiftly to install Swift #{swift_version}..."
        system "swiftly", "install", swift_version
        system "swiftly", "use", swift_version

        # Update PATH to use swiftly's Swift
        swiftly_bin = if OS.mac?
          "#{Dir.home}/Library/Developer/Toolchains/swift-#{swift_version}.xctoolchain/usr/bin"
        else
          "#{Dir.home}/.local/share/swiftly/toolchains/#{swift_version}/usr/bin"
        end

        ENV.prepend_path "PATH", swiftly_bin if File.directory?(swiftly_bin)
      end
    end

    if OS.mac?
      system "swift", "build", "--disable-sandbox", "-c", "release", "--product", "edge"
      bin.install ".build/release/edge"

      # Install macOS-specific bundle with resources (plist files, etc)
      bundle_path = ".build/release/edge-agent_edge.bundle"
      (lib/"edge").install bundle_path if File.directory?(bundle_path)
    else
      # Linux build - just the CLI binary with static linking
      system "swift", "build", "--static-swift-stdlib", "-c", "release", "--product", "edge"
      bin.install ".build/release/edge"
    end
  end

  test do
    # TODO: It would be better to actually build something, instead of just checking the help text.
    system bin/"edge", "--help"
    assert_match "OVERVIEW: Edge CLI", shell_output("#{bin}/edge --help")
  end
end
