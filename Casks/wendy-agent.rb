cask "wendy-agent" do
  version "2026.06.02-204007"
  sha256 "d9dea1b72c0a5849249eba66dba08d3cb0cdb61f5a417fcf34cbd29dfa4acb6d"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
