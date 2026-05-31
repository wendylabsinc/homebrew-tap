cask "wendy-agent-nightly" do
  version "2026.05.31-110207"
  sha256 "9a61b6a47bf7020fd740da02fc16e046c0d3cacb3d3f9cb26043a7a3fea2efb2"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
