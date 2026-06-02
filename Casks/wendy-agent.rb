cask "wendy-agent" do
  version "2026.06.02-064201"
  sha256 "f210a636cc0820ecb285b55eb555a2992075c441a72737560b85e2ddd26bfe13"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
