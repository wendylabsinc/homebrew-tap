cask "wendy-agent-nightly" do
  version "2026.11.09-171923"
  sha256 "8cbe1149129c3143a2ba918eee298a9b0940e988aa647d9b6f7b95a433f85f88"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
