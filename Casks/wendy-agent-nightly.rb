cask "wendy-agent-nightly" do
  version "2026.08.03-163706"
  sha256 "6b9d88cd52a8c9200be14fb438345be71e5591259be333c02420993a2f71354f"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
