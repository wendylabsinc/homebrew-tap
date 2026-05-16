cask "wendy-agent-nightly" do
  version "2026.05.16-195933"
  sha256 "bee2a618e45cdec5129b88ee9afd5f0100df28af7dbcca896efce1546006f591"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  app "WendyAgentMac.app"
end
