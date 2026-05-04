cask "wendy-agent" do
  version "2026.05.04-145708"
  sha256 "114273b60d513e3ec5d28d3404b30482b7e0c4c6e386469e3eacf1465ea9b62f"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  app "WendyAgentMac.app"
end
