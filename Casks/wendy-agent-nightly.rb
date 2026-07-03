cask "wendy-agent-nightly" do
  version "2026.07.03-123316"
  sha256 "0e2d3a865bd4cbae7ced26fd83552a61399f0b7b269040649e7918e98c882864"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
