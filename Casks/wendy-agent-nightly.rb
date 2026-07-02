cask "wendy-agent-nightly" do
  version "2026.07.02-135819"
  sha256 "8baf2d6861e13683cfb6616f417ceb5e67048512d3b042a8a958661767c391cd"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
