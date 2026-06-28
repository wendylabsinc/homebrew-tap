cask "wendy-agent-nightly" do
  version "2026.06.28-202604"
  sha256 "888b4477cb350d3df011808a43c166b2de8e59cae4206c7fe4700087990f8d30"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
