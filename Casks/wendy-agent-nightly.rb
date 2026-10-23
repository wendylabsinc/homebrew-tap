cask "wendy-agent-nightly" do
  version "2026.10.23-191523"
  sha256 "2190d8b41673d9c789918952f6300ef684fdecb974de4ad24cae3279f0c5de67"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
