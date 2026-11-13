cask "wendy-agent" do
  version "2026.11.13-154136"
  sha256 "4a87e9fb75ed38580f1d0a5a70ba5492754f14484476c4f55da3adaab231f65f"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
