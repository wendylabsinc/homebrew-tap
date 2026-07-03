cask "wendy-agent-nightly" do
  version "2026.07.03-142447"
  sha256 "16f9855afca5f471c62b71e4489054b5e4578886e4e1c7e941316acd421bdfb7"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
