cask "wendy-agent-nightly" do
  version "2026.11.03-071255"
  sha256 "b30ef5db09aad53ab9e4f57e5fda07fdc4de67c2c9f464f7f497735194da0fff"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
