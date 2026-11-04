cask "wendy-agent-nightly" do
  version "2026.11.04-160148"
  sha256 "ce9f14c474a28e1aadc1d8d2ec906f353f7dd595a8bbe9ff6b9489584b348905"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
