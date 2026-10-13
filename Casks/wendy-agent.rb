cask "wendy-agent" do
  version "2026.10.13-144211"
  sha256 "0fff4ae7d65fabddb58ed1cb5c5bd7a2929cda2aca029d951a93d3d6294271cf"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
