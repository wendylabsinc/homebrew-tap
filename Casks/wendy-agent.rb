cask "wendy-agent" do
  version "2026.06.12-113052"
  sha256 "4bf52d9623f9a740efa836d5bc31e3c87e5757c3c8c0c3b2d7b2a5d2e1e56611"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
