cask "wendy-agent-nightly" do
  version "2026.07.31-000200"
  sha256 "2a76b9f701f066968487e2d91e433721c7c0f95209f6271d5022c6d01e7c56a6"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
