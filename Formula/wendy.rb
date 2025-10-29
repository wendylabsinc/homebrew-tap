class Wendy < Formula
  desc "CLI for building and running WendyOS applications"
  homepage "https://github.com/wendylabsinc/wendy-agent"
  version "2025.10.28-172858"

  # bottle do
  #   root_url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.10.24-142919"
  #   rebuild 1
  #   sha256 cellar: :any_skip_relocation, arm64_tahoe:
  #     "0b826c8023f741c32d40d771a1cfca69865e0ac88a1e51aa76245e70eaf716c7"
  # end

  # Use source tarball for macOS (needs to build from source)
  if OS.mac?
    url "https://github.com/wendylabsinc/wendy-agent/archive/refs/tags/2025.10.28-172858.tar.gz"
    sha256 "86684507cd49886d82aaa508508ed81c234949eb771ff51729fc6a61a233f94e"
  # Use pre-built binaries for Linux
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.10.28-172858/wendy-cli-linux-static-musl-aarch64.tar.gz"
      sha256 "a52f35021d00acc8d56c42661f14aa27023cfef5f6daeeb3ccb97e1ee1e28f18"
    else
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.10.28-172858/wendy-cli-linux-static-musl-x86_64.tar.gz"
      sha256 "851a0a0b1331f73b585a52e463d15c44b0dea4b8921453c31ffd99e021b49e0b"
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
