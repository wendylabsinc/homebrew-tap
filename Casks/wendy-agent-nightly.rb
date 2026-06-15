cask "wendy-agent-nightly" do
  version "2026.06.15-234103"
  sha256 "a8415bdbfe49dfd0eefa391f88abf07f73e9c01602b81aa813985e8baa130b1c"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
