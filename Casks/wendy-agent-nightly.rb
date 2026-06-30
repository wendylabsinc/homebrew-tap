cask "wendy-agent-nightly" do
  version "2026.06.30-175529"
  sha256 "a7e3f1dd895f3a030bd72d4f5458ec3343c315163e7ff2e478dd8dcc925efa8e"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
