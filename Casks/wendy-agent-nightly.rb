cask "wendy-agent-nightly" do
  version "2026.08.08-084214"
  sha256 "dab8888db6897c3cff1845bf1081fe00774748d5766fcdbba16c9a1e4536b45b"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
