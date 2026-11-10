cask "wendy-agent" do
  version "2026.11.10-171611"
  sha256 "b8c1418d18f8861a6e234e53b0954857467519d8887e463b0531874b2e1dbd4f"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
