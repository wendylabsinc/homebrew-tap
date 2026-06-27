cask "wendy-agent-nightly" do
  version "2026.06.27-193417"
  sha256 "8c39647cf700cf1a8b932bd38dd298f8149c7211b85187bdfea4b5f03b41a571"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
