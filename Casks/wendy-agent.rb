cask "wendy-agent" do
  version "2026.05.09-220252"
  sha256 "c533d06b7575eaff8c979d8d2f4433eb0974f8490b1a1895cfa0e665d9300acd"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  app "WendyAgentMac.app"
end
