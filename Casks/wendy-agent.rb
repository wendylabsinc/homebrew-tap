cask "wendy-agent" do
  version "2026.11.11-074541"
  sha256 "cbaf459c08ee3dd773e76d73a9a09f1acb3149a55a86e3fa065813eee2a31ea6"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
