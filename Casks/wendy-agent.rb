cask "wendy-agent" do
  version "2026.11.10-055158"
  sha256 "c76666a13384f318f6767856519d6071d355b51500dcde78b67eb6a2ce4504ff"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
