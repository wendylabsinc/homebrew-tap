cask "wendy-agent-nightly" do
  version "2026.11.09-161350"
  sha256 "ff5337b04296b2df121b5d2cd9f749b7caff9d1036c58ebaa3c605ba468f2e24"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
