cask "wendy-agent" do
  version "2026.08.18-022337"
  sha256 "166f22e487a40a7d4a6f27892e892a19d21ac6b34b49b335b13cef1aa9088f20"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
