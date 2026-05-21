cask "wendy-agent" do
  version "2026.05.20-174037"
  sha256 "b97015e5dd787146bd1f9f3bbb94065fa9c373f5f51e93f6f44aa11a34d6c64b"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
