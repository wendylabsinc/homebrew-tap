cask "wendy-agent-nightly" do
  version "2026.07.04-143032"
  sha256 "58c7d3e89077cce1f08910bc417953080db5af831f382ed0ee62c4c32074aac5"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
