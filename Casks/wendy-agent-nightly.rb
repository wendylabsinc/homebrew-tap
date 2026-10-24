cask "wendy-agent-nightly" do
  version "2026.10.24-111414"
  sha256 "08e84c35291bd9d7586df49363f92aefd384a45e7419e8777cb2c8c88431c77d"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
