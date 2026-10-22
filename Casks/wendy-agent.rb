cask "wendy-agent" do
  version "2026.10.22-004609"
  sha256 "dbf42969f04ae08d27a0f06a6e20516f5cc822f5be13c20e8c926a0735c7d809"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
