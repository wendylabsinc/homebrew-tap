cask "wendy-agent" do
  version "2026.11.10-023507"
  sha256 "f8e4a665448256f9515b82d5247a3df3c3fbabba11d6a04c7ab508b97f7e387a"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
