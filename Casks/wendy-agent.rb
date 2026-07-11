cask "wendy-agent" do
  version "2026.07.11-160515"
  sha256 "a278bf7f107398ecd9e0919f33d60361b8ed947cd678974922c445d40a5e8b77"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
