cask "wendy-agent" do
  version "2026.07.15-123149"
  sha256 "26533c3eb9115fa0f9aeaaecc76f009c44bf9f2b016756ee502d858d1c3d1ac1"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
