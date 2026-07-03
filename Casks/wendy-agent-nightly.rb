cask "wendy-agent-nightly" do
  version "2026.07.03-111153"
  sha256 "520e12c13e6d3bd6970035e1b57753db527dabde77a1bcdb308c7f461c8d70a4"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
