cask "wendy-agent-nightly" do
  version "2026.06.11-062539"
  sha256 "3efdeea69adb68a8c0bd5c328ebbfe27a3f1c428b4896e8dd68c98e096cd9574"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
