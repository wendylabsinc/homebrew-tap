cask "wendy-agent-nightly" do
  version "2026.07.30-023450"
  sha256 "a6b557cf62daa3790826955b5f0ffaa02660e574336f7e68cbf78de5dcec4eb4"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
