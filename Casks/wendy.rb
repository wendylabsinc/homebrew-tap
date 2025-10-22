cask "wendy" do
  version "2025.10.22-190204"
  desc "CLI for building and running WendyOS applications"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  # Architecture-specific downloads
  on_macos do
    url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.10.22-190204/wendy-cli-macos-arm64.tar.gz"
    sha256 "51f354e03dbcb82e2097f29baa6a74d564386b2c1c04fbb9caa45d9e5bbee99e"
  end

  on_linux do
    on_arm do
      sha256 "b969fef8e20d0bc2141e7729a3482a98c8aefe6824f3ef2a498fa119d0a31bca"
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.10.22-190204/wendy-cli-linux-static-musl-aarch64.tar.gz"
    end
    on_intel do
      sha256 "61d0db102cc4d0c98fb29120e2f1425d6d3af7b9ce9edd657c95ae32512396d7"
      url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.10.22-190204/wendy-cli-linux-static-musl-x86_64.tar.gz"
    end
  end

  # Install the binary
  binary "wendy"
  artifact "wendy-agent_wendy.bundle",
           target: "#{Dir.home}/Library/Application Support/wendy/wendy-agent_wendy.bundle"
end
