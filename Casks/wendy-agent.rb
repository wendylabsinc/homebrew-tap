cask "wendy-agent" do
  version "2026.07.17-173113"
  sha256 "038e429cc4b9cba941f9a6e28792dc0e81cea2a4a7e2e364b48f548664444be9"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
