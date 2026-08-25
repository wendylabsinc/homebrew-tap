cask "wendy-agent-nightly" do
  version "2026.08.25-104401"
  sha256 "64b381fa5c1d9ce9b72413569accb1753ef06b8fd0091601a06362f18beb0ba4"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
