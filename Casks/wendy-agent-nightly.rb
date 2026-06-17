cask "wendy-agent-nightly" do
  version "2026.06.17-102749"
  sha256 "c2f1ef60e0d0291a87856e6e29c80166a6aaa8ca5a088fa1af172ea4a134780f"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
