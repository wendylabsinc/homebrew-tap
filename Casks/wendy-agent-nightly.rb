cask "wendy-agent-nightly" do
  version "2026.07.21-153741"
  sha256 "c89950d9d580a124c046b462bb20f101f8bd10022083ee272f8a94ae00ed59ed"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
