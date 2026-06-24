cask "wendy-agent" do
  version "2026.06.24-144703"
  sha256 "ca22b934adbf55e3928b30d89c722cf76e499634c7af81fc03d1a614e2373894"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
