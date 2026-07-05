cask "wendy-agent-nightly" do
  version "2026.07.05-162659"
  sha256 "76b6cab275bf4011dc2ccb170cd83782de13c7f49fc8b656ec7d4a61a37f72ef"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
