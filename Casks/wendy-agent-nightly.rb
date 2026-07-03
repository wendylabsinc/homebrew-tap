cask "wendy-agent-nightly" do
  version "2026.07.03-134610"
  sha256 "10124c54844d8fcc132c1805c61ffbd924b928e906128b6d7c45c44eebce8417"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
