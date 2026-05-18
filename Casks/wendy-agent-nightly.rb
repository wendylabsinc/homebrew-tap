cask "wendy-agent-nightly" do
  version "2026.05.18-211056"
  sha256 "1efb91f3b48edc25198f42eac90ad0809d1941033c64b6452b3c550e9d4848fb"

  url "https://github.com/wendylabsinc/wendy-agent/releases/download/#{version}/wendy-agent-macos-arm64-#{version}.zip"
  name "Wendy Agent"
  desc "Manage your headless device (nightly)"
  homepage "https://github.com/wendylabsinc/wendy-agent"

  depends_on :macos

  app "WendyAgentMac.app"
end
