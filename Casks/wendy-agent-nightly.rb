cask "wendy-agent-nightly" do
  version "2026.06.27-203254"
  sha256 "fce5b18e3c8257d5746f9d34b6bb92b25b96ba9b9a7d061a3110876c7bf51699"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
