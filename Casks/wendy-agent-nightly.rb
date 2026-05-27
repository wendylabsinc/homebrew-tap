cask "wendy-agent-nightly" do
  version "2026.05.27-052629"
  sha256 "0a086545c13e0587a3963f027f49b476eadfb4efc86339dbc7124bee121b194f"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
