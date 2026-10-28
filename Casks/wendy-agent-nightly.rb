cask "wendy-agent-nightly" do
  version "2026.10.28-155305"
  sha256 "9c5ecd54e852e7f1bd197625f7f971e9c4c086dc871ce9459620b7c12c0afcd0"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
