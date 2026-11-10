cask "wendy-agent-nightly" do
  version "2026.11.10-085608"
  sha256 "051d460106d96a35823735cc1bd50e0d1b34d12d81a22da93a773b11b39dfb9d"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
