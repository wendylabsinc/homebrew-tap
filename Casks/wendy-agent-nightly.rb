cask "wendy-agent-nightly" do
  version "2026.10.14-181439"
  sha256 "872534a57a02e4198b0ffcb5fb61d877928a015d5b162654100e2556e6351c74"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
