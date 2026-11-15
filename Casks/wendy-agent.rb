cask "wendy-agent" do
  version "2026.11.15-074641"
  sha256 "615b4eb71d1c9b8a655889e867c07c0674a422dc461dc0242f87b592d03b718d"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
