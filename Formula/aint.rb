class Aint < Formula
  desc "Static analyzer for hardcoded secrets, broad IAM permissions, and code bugs"
  homepage "https://github.com/wendylabsinc/aint"
  url "https://github.com/wendylabsinc/aint/archive/b5587e3c2de3629db93e62dcdfa08d0c93851de0.tar.gz"
  version "2026.08.01-223710"
  sha256 "a56d03a28cfcedb866313ef297e00974bc5d8247e9c5e86b097e6f0268a613b3"
  license "Apache-2.0"
  head "https://github.com/wendylabsinc/aint.git", branch: "main"

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w"), "./cmd/aint"
  end

  test do
    assert_match "go-ignored-error", shell_output("#{bin}/aint list")
    system bin/"aint", "check", "."
  end
end
