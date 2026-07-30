cask "wendy-agent-nightly" do
  version "2026.07.30-073528"
  sha256 "88d790a98b2a5e98d59f1df5f5169483c4acffb43b2c37a009616a44acfe5c05"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
