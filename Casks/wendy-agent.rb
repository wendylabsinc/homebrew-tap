cask "wendy-agent" do
  version "2026.06.04-163109"
  sha256 "ded124acf438a308622b7bb94193c889c0255094a90db4f37690daf44863e5a6"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
