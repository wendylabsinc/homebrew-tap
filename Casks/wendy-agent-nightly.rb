cask "wendy-agent-nightly" do
  version "2026.05.17-191501"
  sha256 "f7888bd079eaec05a21fd8df6575b6d667dbfec90b9d7b4ac8702bf87739854c"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
