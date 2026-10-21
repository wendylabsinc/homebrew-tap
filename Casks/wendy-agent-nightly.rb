cask "wendy-agent-nightly" do
  version "2026.10.21-123114"
  sha256 "c613afa05ff6a0b0c9333949794941a85aef058d9a43f95753ef62585319b290"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
