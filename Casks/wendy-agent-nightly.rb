cask "wendy-agent-nightly" do
  version "2026.08.28-213115"
  sha256 "446a6ff4f63462b0cc58238796917db3f1662101829939d51e2dd4434be8fdcb"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
