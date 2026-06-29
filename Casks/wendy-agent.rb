cask "wendy-agent" do
  version "2026.06.29-163039"
  sha256 "5bb98976e8299231dd8d9325856753ec8fe8db27d045d1a10b2de93e50bb2138"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
