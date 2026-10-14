cask "wendy-agent" do
  version "2026.10.14-064751"
  sha256 "9ae3d98c0dcb0e486571de79f944ba72b3cf91fa3e41f30b416c81306f7af4d8"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
