cask "wendy-agent" do
  version "2026.06.18-214208"
  sha256 "119e832f62ef7766624b62e4dc33d371b0b7d0f53b1543c80ba72ad676babf99"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
