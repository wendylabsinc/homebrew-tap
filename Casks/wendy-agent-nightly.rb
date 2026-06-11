cask "wendy-agent-nightly" do
  version "2026.06.11-164151"
  sha256 "ec79593af97e741337915110837e1897a774253784cef4e2fe35b9311c390974"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
