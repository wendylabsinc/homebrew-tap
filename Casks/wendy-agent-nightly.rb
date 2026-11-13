cask "wendy-agent-nightly" do
  version "2026.11.13-102129"
  sha256 "9c00d44d61b6b9f72ef8a423db77138d13aa5e2b0a183228243df6559ce971f0"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
