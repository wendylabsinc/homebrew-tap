cask "wendy-agent-nightly" do
  version "2026.06.10-114159"
  sha256 "2c87eca18f0b404bc31bbf4a86ac079191fdb2e9816863842a6a66d404ec8d9b"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
