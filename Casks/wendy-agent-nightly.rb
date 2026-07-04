cask "wendy-agent-nightly" do
  version "2026.07.04-121617"
  sha256 "63d3ccab9b44502e2ae2a968c3c5cdaed4a2aa319921d398305a62ff9b2df568"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
