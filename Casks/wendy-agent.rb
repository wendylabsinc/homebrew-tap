cask "wendy-agent" do
  version "2026.08.13-010134"
  sha256 "65232e2b19de8624521f98e1586ed75861090988ad4ddc07e5edbaedb9c3c8b2"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
