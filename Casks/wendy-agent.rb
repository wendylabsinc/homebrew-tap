cask "wendy-agent" do
  version "2026.06.25-153233"
  sha256 "b61c5bf3020318ec55794fde04afd722181e0fc19239f460a1cb4ea555fec875"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
