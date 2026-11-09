cask "wendy-agent-nightly" do
  version "2026.11.09-232739"
  sha256 "f34b3db403c288f3fd14564f9dd59494c370f23c7fe0b750de4ee63bed1d765b"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
