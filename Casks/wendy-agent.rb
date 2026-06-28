cask "wendy-agent" do
  version "2026.06.28-085832"
  sha256 "5541d6801adb629ba2d92dd49624cd39ffadd4374f2ace1520b5cfa7d00e1b7d"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
