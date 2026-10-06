cask "wendy-agent-nightly" do
  version "2026.10.06-112430"
  sha256 "191345faa51e174924c9b7b3e32a6194957c3e84ba454b655476d5217f320ccd"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
