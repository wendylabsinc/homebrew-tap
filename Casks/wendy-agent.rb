cask "wendy-agent" do
  version "2026.07.03-194041"
  sha256 "dc57fab510e8efa3dc897d1937003157e98c9e90df7006a2b3af4091de48c3c3"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
