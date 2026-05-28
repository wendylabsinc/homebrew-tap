cask "wendy-agent-nightly" do
  version "2026.05.28-174222"
  sha256 "dfcfebd0a1adacf7a56231e35e22e8ac49cb5f4086d100ed81a01f2fbbd45805"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
