cask "wendy-agent" do
  version "2026.10.25-191108"
  sha256 "337b0763ffa0d2a1979e5c17526b3cd6e00672f4715c85f9cc82b06877ea9ee2"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
