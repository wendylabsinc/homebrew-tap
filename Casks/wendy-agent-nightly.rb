cask "wendy-agent-nightly" do
  version "2026.07.07-095152"
  sha256 "2cdf5f771e86c432a2673a606b41c5e2bc999f8dfc69b6382ba440d569c6a973"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
