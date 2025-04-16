class Edge < Formula
  desc "CLI for building and running Edge applications"
  homepage "https://github.com/apache-edge/edge-agent"
  url "https://github.com/apache-edge/edge-agent/archive/refs/tags/v2025.04.16-151540.tar.gz"
  sha256 "8d92da8fa23bc8cba0277f04f4dee463dd35f90ff7476d5df1bd041805502a60"
  license "Apache-2.0"
  head "https://github.com/apache-edge/edge-agent.git", branch: "main"

  depends_on xcode: ["16.3", :build]
  uses_from_macos "swift" => :build

  def install
    args = if OS.mac?
      ["--disable-sandbox"]
    else
      ["--static-swift-stdlib"]
    end

    system "./Scripts/inject-version.sh", "#{version}"
    system "swift", "build", *args, "-c", "release", "--product", "edge"

    bin.install ".build/release/edge"
    # TODO: install resources, see: https://github.com/swiftlang/swift-package-manager/issues/8510
  end

  test do
    # TODO: It would be better to actually build something, instead of just checking the help text.
    system bin/"edge", "--help"
    assert_match "OVERVIEW: Edge CLI", shell_output("#{bin}/edge --help")
  end
end
