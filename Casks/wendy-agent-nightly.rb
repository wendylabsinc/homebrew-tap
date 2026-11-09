cask "wendy-agent-nightly" do
  version "2026.11.09-225545"
  sha256 "910be9525ef77ca365ff7fe7a18480e48411dd3d5d0963d435ac2450c126781a"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
