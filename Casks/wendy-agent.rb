cask "wendy-agent" do
  version "2026.11.27-165438"
  sha256 "c57b386d9887eb69e41dcd5c2aa662574248c72b6464f52c8a0e458952c8b954"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
