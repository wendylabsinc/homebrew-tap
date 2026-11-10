cask "wendy-agent" do
  version "2026.11.10-171632"
  sha256 "181c1fca4037dead4cbfe96d1add5f572e9328de54cab28bc4b22f4fcd66de3a"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
