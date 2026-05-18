cask "wendy-agent" do
  version "2026.05.18-104720"
  sha256 "73203416f283b6e98b135ea315ee89dd497e7616aa2baab355521c6ff45ca8ab"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  app "WendyAgentMac.app"
end
