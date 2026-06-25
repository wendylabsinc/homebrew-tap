cask "wendy-agent-nightly" do
  version "2026.06.25-145618"
  sha256 "6ecf9f5aa5af8887c99ab778f91db82511c5603cab3ef56f4a7bfa6a68460d85"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
