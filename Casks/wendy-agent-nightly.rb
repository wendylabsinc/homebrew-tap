cask "wendy-agent-nightly" do
  version "2026.06.11-135137"
  sha256 "cbb1f28e245f166d2d6000c98dbc937313c8a882d3c360e77a3f642adb4060b1"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
