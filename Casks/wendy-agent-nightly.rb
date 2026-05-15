cask "wendy-agent-nightly" do
  version "2026.05.15-221130"
  sha256 "daa2c41c8cdb49a4b3f724d1261af0f58598bb7b25260a5ddf91e41b62af8942"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  app "WendyAgentMac.app"
end
