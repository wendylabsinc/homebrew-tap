cask "wendy" do
  version "2025.10.24-142919"
  desc "CLI for building and running WendyOS applications"
  homepage "https://github.com/wendylabsinc/wendy-agent"
  
  url "https://github.com/wendylabsinc/wendy-agent/releases/download/2025.10.24-142919/wendy-cli-macos-arm64.tar.gz"
  sha256 "cbe1d957dccc003d84cce2e58040462379fb24cf34016ed07c107c99ad2e7bab"

  # Install the binary
  binary "wendy-cli-macos-arm64/wendy"
  artifact "wendy-cli-macos-arm64/wendy-agent_wendy.bundle",
           target: "/Library/Application Support/Wendy/wendy-agent_wendy.bundle"
end
