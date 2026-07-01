cask "wendy-agent" do
  version "2026.07.01-174142"
  sha256 "c6339264500f96240fea9393720c763a55576a2bc9e0cb6d62b08d338277a602"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
