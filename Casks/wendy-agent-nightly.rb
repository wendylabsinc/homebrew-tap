cask "wendy-agent-nightly" do
  version "2026.06.17-151132"
  sha256 "e620aef1d6955cd5345ea84c9d2914073bad058f8b37017f0b0450853d6f9565"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
