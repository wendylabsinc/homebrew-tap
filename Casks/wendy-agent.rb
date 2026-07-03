cask "wendy-agent" do
  version "2026.07.03-154322"
  sha256 "056de681adac663fe6c03fb88bd331954d3c3e797349235a91a6d91c322a2f83"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
