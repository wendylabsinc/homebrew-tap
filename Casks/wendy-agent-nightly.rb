cask "wendy-agent-nightly" do
  version "2026.10.24-081759"
  sha256 "2db597df73716693b74478bc7ef866b673f465fee6ed28eb669315f438a56d98"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
