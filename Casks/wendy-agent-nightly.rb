cask "wendy-agent-nightly" do
  version "2026.06.17-123819"
  sha256 "0996aa9e499a0cc14cbd04fa569d34770ee74d4a83fed73b4e03b9f76b620445"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
