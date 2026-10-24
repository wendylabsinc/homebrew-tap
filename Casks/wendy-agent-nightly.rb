cask "wendy-agent-nightly" do
  version "2026.10.24-132509"
  sha256 "436fa910cbdee73309103878f8138787f74b55b05a7159a126507a67b1749993"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
