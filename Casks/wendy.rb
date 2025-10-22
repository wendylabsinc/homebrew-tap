cask "wendy" do
  version "2025.10.22-190204"
  desc "CLI for building and running WendyOS applications"
  homepage "https://github.com/wendylabsinc/wendy-agent"
  
  url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.10.22-190204/wendy-cli-macos-arm64.tar.gz"
  sha256 "51f354e03dbcb82e2097f29baa6a74d564386b2c1c04fbb9caa45d9e5bbee99e"

  # Install the binary
  binary "wendy"
  artifact "wendy-agent_wendy.bundle",
           target: "/Library/Application Support/Wendy/wendy-agent_wendy.bundle"
end
