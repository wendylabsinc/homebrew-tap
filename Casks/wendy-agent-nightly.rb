cask "wendy-agent-nightly" do
  version "2026.06.28-162828"
  sha256 "89a3c2ddb55255c5d02dcc5f87d3d92caaeb5c8d974fc2f467fb13adae480e54"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
