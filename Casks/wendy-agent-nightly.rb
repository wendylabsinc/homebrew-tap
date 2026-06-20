cask "wendy-agent-nightly" do
  version "2026.06.20-091348"
  sha256 "1890990c4c4d5fbe4d18b90b70dc666bc695fb3483722c10942fd6bc5a2c33bb"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
