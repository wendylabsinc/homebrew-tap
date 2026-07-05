cask "wendy-agent" do
  version "2026.07.05-181127"
  sha256 "5c7dc087b640762cc5b9d3746c666394671906f499fed37cec9384b343789780"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
