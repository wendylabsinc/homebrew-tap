cask "wendy-agent" do
  version "2026.06.10-142200"
  sha256 "c5e000160c311df54ff0eb74993e6665874c64ca96562052d0897b101c00d07e"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
