cask "wendy-agent-nightly" do
  version "2026.10.14-085934"
  sha256 "7f07d3286776e7e6ca8d6d6ce371f8973ef90f8854bf2533fbef9ffcd4dc3d82"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
