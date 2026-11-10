cask "wendy-agent-nightly" do
  version "2026.11.10-055138"
  sha256 "4e8b27135591fa116a9b787d6640a7f0493b966091f9fcc806fb08c64c956d1d"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
