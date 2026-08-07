cask "wendy-agent" do
  version "2026.08.07-174446"
  sha256 "744aaf08777f2783cecee3339307535f61a5ed426d647b8d4b5e4d63720c1609"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
