cask "wendy-agent-nightly" do
  version "2026.08.07-233523"
  sha256 "fa14327fe783bae3495f6bd0ba34eafc34c97c4a2a1fe5783064c50dafb83968"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
